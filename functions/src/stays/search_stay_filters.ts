import { HttpsError } from "firebase-functions/v2/https";

import type {
  StayDocument,
  StaySearchFilters,
  StaySearchRequest,
} from "./search_stay_types.js";

const maximumPageSize = 20;
const defaultPageSize = 8;

export function parseStaySearchFilters(
  data: StaySearchRequest,
): StaySearchFilters {
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
    categoryIds: stringList(data.categoryIds),
    collectionIds: stringList(data.collectionIds),
    amenities: stringList(data.amenities),
    inventoryType: optionalInventoryType(data.inventoryType),
    cursor: typeof data.cursor === "string" && data.cursor.length > 0
      ? data.cursor
      : null,
    pageSize: Math.min(
      maximumPageSize,
      Math.max(1, positiveInteger(data.pageSize, defaultPageSize)),
    ),
  };
}

export function matchesStayFilters(
  stay: StayDocument,
  filters: StaySearchFilters,
) {
  const location = asMap(stay.data.location);
  const stayDetails = asMap(stay.data.stayDetails);
  const city = normalizeText(location.city);
  const price = asNumber(stayDetails.pricePerNight);
  const rating = asNumber(stay.data.averageRating);
  const requestedGuests = filters.adults + filters.children;
  const rooms = asList(stayDetails.rooms).map(asMap);
  const amenities = asList(stayDetails.amenities).map(String);
  const featuredCollectionIds = stay.data.featuredCollectionIds == null
    ? inferredCollectionIds(String(stay.data.categoryId ?? ""), amenities)
    : asList(stay.data.featuredCollectionIds).map(String);
  const hasSuitableRoom = rooms.length === 0 || rooms.some(
    (room) => asNumber(room.maxGuests) >= requestedGuests,
  );

  return (
    (filters.city == null || city === filters.city) &&
    price >= filters.minPrice &&
    price <= filters.maxPrice &&
    rating >= filters.minimumRating &&
    (filters.categoryIds.length === 0 || filters.categoryIds.includes(String(stay.data.categoryId ?? ""))) &&
    (filters.collectionIds.length === 0 || filters.collectionIds.some((id) => featuredCollectionIds.includes(id))) &&
    (filters.inventoryType == null || String(stayDetails.inventoryType ?? (rooms.length > 0 ? "multipleUnits" : "singleUnit")) === filters.inventoryType) &&
    filters.amenities.every((amenity) => amenities.includes(amenity)) &&
    hasSuitableRoom
  );
}

export function asMap(value: unknown): Record<string, unknown> {
  return value != null && typeof value === "object" && !Array.isArray(value)
    ? value as Record<string, unknown>
    : {};
}

export function asList(value: unknown): unknown[] {
  return Array.isArray(value) ? value : [];
}

export function asNumber(value: unknown) {
  const number = Number(value);
  return Number.isFinite(number) ? number : 0;
}

export function normalizeText(value: unknown) {
  if (typeof value !== "string") return null;
  const normalized = value
    .trim()
    .toLowerCase()
    .replaceAll("č", "c")
    .replaceAll("ć", "c")
    .replaceAll("š", "s")
    .replaceAll("ž", "z")
    .replaceAll(/[^a-z0-9 ]/g, "")
    .replaceAll(/\s+/g, " ");
  return normalized.length === 0 ? null : normalized;
}

function inferredCollectionIds(categoryId: string, amenities: string[]) {
  const collectionIds = new Set<string>();
  if (["beach_villa", "villa", "pool_villa"].includes(categoryId) || amenities.includes("seaView")) collectionIds.add("beachfront_stays");
  if (["cabin", "mountain_cabin", "cottage", "vacation_home"].includes(categoryId)) collectionIds.add("weekend_escapes");
  if (["hotel", "resort", "villa"].includes(categoryId) || amenities.includes("spa")) collectionIds.add("romantic_getaways");
  if (["hotel", "resort", "apartment", "aparthotel"].includes(categoryId) || amenities.includes("pool")) collectionIds.add("family_friendly");
  if (amenities.includes("petFriendly")) collectionIds.add("pet_friendly");
  if (amenities.includes("pool")) collectionIds.add("pool_stays");
  if (["cabin", "mountain_cabin", "cottage", "glamping"].includes(categoryId) || amenities.includes("mountainView")) collectionIds.add("mountain_escapes");
  if (["hotel", "apartment", "aparthotel", "hostel"].includes(categoryId)) collectionIds.add("city_breaks");
  return [...collectionIds];
}

function parseDate(value: unknown, field: string) {
  if (value == null) return null;
  if (typeof value !== "string") throw new HttpsError("invalid-argument", `${field} must be an ISO date string.`);
  const date = new Date(value);
  if (Number.isNaN(date.valueOf())) throw new HttpsError("invalid-argument", `${field} is not a valid date.`);
  return date;
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

function stringList(value: unknown) {
  if (!Array.isArray(value)) return [];
  return [...new Set(value.filter((item): item is string => typeof item === "string").map((item) => item.trim()).filter(Boolean))];
}

function optionalInventoryType(value: unknown): StaySearchFilters["inventoryType"] {
  return value === "singleUnit" || value === "multipleUnits" ? value : null;
}
