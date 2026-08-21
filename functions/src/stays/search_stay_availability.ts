import { Timestamp, type Firestore } from "firebase-admin/firestore";

import { asList, asMap, asNumber } from "./search_stay_filters.js";
import { loadActiveBookings } from "./search_stay_documents.js";
import type { StayDocument, StaySearchFilters } from "./search_stay_types.js";

export async function filterAvailableStays(
  database: Firestore,
  stays: StayDocument[],
  filters: StaySearchFilters,
) {
  if (filters.checkIn == null || filters.checkOut == null || stays.length === 0) {
    return stays;
  }
  const bookings = await loadActiveBookings(
    database,
    stays.map((stay) => stay.id),
    filters.checkIn,
    filters.checkOut,
  );
  return stays.filter((stay) => isStayAvailable(stay, bookings, filters));
}

function isStayAvailable(
  stay: StayDocument,
  bookings: Record<string, unknown>[],
  filters: StaySearchFilters,
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

function overlaps(
  bookingCheckIn: Date | null,
  bookingCheckOut: Date | null,
  checkIn: Date,
  checkOut: Date,
) {
  return bookingCheckIn != null && bookingCheckOut != null && bookingCheckIn < checkOut && bookingCheckOut > checkIn;
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
