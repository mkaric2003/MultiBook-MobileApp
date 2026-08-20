import { getFirestore, Timestamp, type Firestore } from "firebase-admin/firestore";
import { HttpsError, onCall } from "firebase-functions/v2/https";

const maximumPageSize = 20;
const defaultPageSize = 8;
const activeBookingStatuses = new Set(["confirmed"]);

type SearchStaysRequest = {
  city?: unknown;
  checkIn?: unknown;
  checkOut?: unknown;
  adults?: unknown;
  children?: unknown;
  minPrice?: unknown;
  maxPrice?: unknown;
  minimumRating?: unknown;
  cursor?: unknown;
  pageSize?: unknown;
};

type StayDocument = {
  id: string;
  data: Record<string, unknown>;
};

export const searchStays = onCall<SearchStaysRequest>(
  { region: "us-central1" },
  async (request) => {
    if (request.auth == null) {
      throw new HttpsError("unauthenticated", "You need to sign in to search stays.");
    }

    const filters = parseFilters(request.data);
    const database = getFirestore();
    const snapshot = await database
      .collection("businesses")
      .where("type", "==", "stays")
      .where("isActive", "==", true)
      .get();

    let stays = snapshot.docs.map((document) => ({
      id: document.id,
      data: document.data(),
    }));
    stays = stays.filter((stay) => matchesStayFilters(stay, filters));

    if (filters.checkIn != null && filters.checkOut != null) {
      const bookings = await loadActiveBookings(
        database,
        stays.map((stay) => stay.id),
      );
      stays = stays.filter((stay) => isAvailable(stay, bookings, filters));
    }

    stays.sort(compareStays);
    const startIndex = cursorIndex(stays, filters.cursor);
    const page = stays.slice(startIndex, startIndex + filters.pageSize);
    const nextCursor = startIndex + filters.pageSize < stays.length
      ? page.at(-1)?.id ?? null
      : null;

    return {
      items: page.map((stay) => serializeStay(stay)),
      nextCursor,
    };
  },
);

function parseFilters(data: SearchStaysRequest) {
  const checkIn = parseDate(data.checkIn, "checkIn");
  const checkOut = parseDate(data.checkOut, "checkOut");
  if (checkIn != null && checkOut != null && checkOut <= checkIn) {
    throw new HttpsError("invalid-argument", "Check-out must be after check-in.");
  }

  return {
    city: normalizeText(data.city),
    checkIn,
    checkOut,
    adults: positiveInteger(data.adults, 1),
    children: nonNegativeInteger(data.children, 0),
    minPrice: nonNegativeNumber(data.minPrice, 0),
    maxPrice: nonNegativeNumber(data.maxPrice, Number.MAX_SAFE_INTEGER),
    minimumRating: nonNegativeNumber(data.minimumRating, 0),
    cursor: typeof data.cursor === "string" && data.cursor.length > 0 ? data.cursor : null,
    pageSize: Math.min(
      maximumPageSize,
      Math.max(1, positiveInteger(data.pageSize, defaultPageSize)),
    ),
  };
}

function matchesStayFilters(
  stay: StayDocument,
  filters: ReturnType<typeof parseFilters>,
) {
  const location = asMap(stay.data.location);
  const stayDetails = asMap(stay.data.stayDetails);
  const city = normalizeText(location.city);
  const price = asNumber(stayDetails.pricePerNight);
  const rating = asNumber(stay.data.averageRating);
  const requestedGuests = filters.adults + filters.children;
  const rooms = asList(stayDetails.rooms).map(asMap);
  const hasSuitableRoom = rooms.length === 0 || rooms.some(
    (room) => asNumber(room.maxGuests) >= requestedGuests,
  );

  return (
    (filters.city == null || city === filters.city) &&
    price >= filters.minPrice &&
    price <= filters.maxPrice &&
    rating >= filters.minimumRating &&
    hasSuitableRoom
  );
}

async function loadActiveBookings(
  database: Firestore,
  businessIds: string[],
) {
  const bookings: Record<string, unknown>[] = [];
  for (const chunk of chunked(businessIds, 30)) {
    const snapshot = await database
      .collection("bookings")
      .where("businessId", "in", chunk)
      .get();
    for (const document of snapshot.docs) {
      const booking = document.data();
      if (activeBookingStatuses.has(String(booking.status))) {
        bookings.push(booking);
      }
    }
  }
  return bookings;
}

function isAvailable(
  stay: StayDocument,
  bookings: Record<string, unknown>[],
  filters: ReturnType<typeof parseFilters>,
) {
  const overlappingBookings = bookings.filter((booking) =>
    booking.businessId === stay.id && overlaps(
      toDate(booking.checkIn),
      toDate(booking.checkOut),
      filters.checkIn!,
      filters.checkOut!,
    ),
  );
  if (overlappingBookings.length === 0) return true;

  const rooms = asList(asMap(stay.data.stayDetails).rooms).map(asMap);
  if (rooms.length === 0) return false;

  const requestedGuests = filters.adults + filters.children;
  return rooms
    .filter((room) => asNumber(room.maxGuests) >= requestedGuests)
    .some((room) => {
      const roomId = String(room.id ?? "");
      const bookedQuantity = overlappingBookings.filter(
        (booking) => booking.roomTypeId == null || booking.roomTypeId === roomId,
      ).length;
      return bookedQuantity < Math.max(1, asNumber(room.quantity));
    });
}

function serializeStay(stay: StayDocument) {
  const data = stay.data;
  return {
    id: stay.id,
    ownerId: String(data.ownerId ?? ""),
    type: "stays",
    name: String(data.name ?? ""),
    categoryId: String(data.categoryId ?? ""),
    location: sanitizeMap(asMap(data.location)),
    shortDescription: data.shortDescription ?? null,
    logoUrl: data.logoUrl ?? null,
    coverPhotoUrl: data.coverPhotoUrl ?? null,
    photoUrls: sanitizeList(asList(data.photoUrls)),
    isActive: true,
    averageRating: asNumber(data.averageRating),
    reviewCount: asNumber(data.reviewCount),
    stayDetails: sanitizeMap(asMap(data.stayDetails)),
  };
}

function compareStays(first: StayDocument, second: StayDocument) {
  const ratingDifference = asNumber(second.data.averageRating) - asNumber(first.data.averageRating);
  if (ratingDifference !== 0) return ratingDifference;
  const reviewsDifference = asNumber(second.data.reviewCount) - asNumber(first.data.reviewCount);
  if (reviewsDifference !== 0) return reviewsDifference;
  return String(first.data.name ?? "").localeCompare(String(second.data.name ?? "")) || first.id.localeCompare(second.id);
}

function cursorIndex(stays: StayDocument[], cursor: string | null) {
  if (cursor == null) return 0;
  const index = stays.findIndex((stay) => stay.id === cursor);
  return index < 0 ? 0 : index + 1;
}

function overlaps(
  bookingCheckIn: Date | null,
  bookingCheckOut: Date | null,
  checkIn: Date,
  checkOut: Date,
) {
  return bookingCheckIn != null && bookingCheckOut != null && bookingCheckIn < checkOut && bookingCheckOut > checkIn;
}

function parseDate(value: unknown, field: string) {
  if (value == null) return null;
  if (typeof value !== "string") {
    throw new HttpsError("invalid-argument", `${field} must be an ISO date string.`);
  }
  const date = new Date(value);
  if (Number.isNaN(date.valueOf())) {
    throw new HttpsError("invalid-argument", `${field} is not a valid date.`);
  }
  return date;
}

function toDate(value: unknown) {
  if (value instanceof Timestamp) return value.toDate();
  if (value instanceof Date) return value;
  if (typeof value === "string") {
    const date = new Date(value);
    return Number.isNaN(date.valueOf()) ? null : date;
  }
  return null;
}

function positiveInteger(value: unknown, fallback: number) {
  const number = Number(value);
  return Number.isInteger(number) && number > 0 ? number : fallback;
}

function nonNegativeInteger(value: unknown, fallback: number) {
  const number = Number(value);
  return Number.isInteger(number) && number >= 0 ? number : fallback;
}

function nonNegativeNumber(value: unknown, fallback: number) {
  const number = Number(value);
  return Number.isFinite(number) && number >= 0 ? number : fallback;
}

function normalizeText(value: unknown) {
  if (typeof value !== "string") return null;
  const normalized = value.trim().toLowerCase();
  return normalized.length === 0 ? null : normalized;
}

function asMap(value: unknown): Record<string, unknown> {
  return value != null && typeof value === "object" && !Array.isArray(value)
    ? value as Record<string, unknown>
    : {};
}

function asList(value: unknown): unknown[] {
  return Array.isArray(value) ? value : [];
}

function asNumber(value: unknown) {
  const number = Number(value);
  return Number.isFinite(number) ? number : 0;
}

function sanitizeMap(map: Record<string, unknown>) {
  return Object.fromEntries(Object.entries(map).map(([key, value]) => [key, sanitizeValue(value)]));
}

function sanitizeList(list: unknown[]) {
  return list.map(sanitizeValue);
}

function sanitizeValue(value: unknown): unknown {
  if (value instanceof Timestamp) return value.toDate().toISOString();
  if (value instanceof Date) return value.toISOString();
  if (Array.isArray(value)) return sanitizeList(value);
  if (value != null && typeof value === "object") return sanitizeMap(value as Record<string, unknown>);
  return value;
}

function chunked<T>(items: T[], size: number) {
  const chunks: T[][] = [];
  for (let index = 0; index < items.length; index += size) {
    chunks.push(items.slice(index, index + size));
  }
  return chunks;
}
