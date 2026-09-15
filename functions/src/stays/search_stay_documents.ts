import { FieldPath, type Firestore } from "firebase-admin/firestore";

import type { StayCursor, StaySearchFilters } from "./search_stay_types.js";

export const stayCandidateBatchSize = 24;

export function createStayCandidateQuery(
  database: Firestore,
  filters: StaySearchFilters,
) {
  let query = database
    .collection("businesses")
    .where("type", "==", "stays")
    .where("isActive", "==", true);

  if (filters.city != null) {
    query = query.where("location.cityLowercase", "==", filters.city);
  } else if (filters.categoryIds.length > 0) {
    query = query.where("categoryId", "in", filters.categoryIds);
  } else if (filters.collectionIds.length > 0) {
    query = query.where("featuredCollectionIds", "array-contains-any", filters.collectionIds);
  }

  return query
    .orderBy("averageRating", "desc")
    .orderBy("reviewCount", "desc")
    .orderBy("name")
    .orderBy(FieldPath.documentId());
}

export async function loadActiveBookings(
  database: Firestore,
  businessIds: string[],
  checkIn: Date,
  checkOut: Date,
) {
  const bookings: Record<string, unknown>[] = [];
  for (const businessIdsChunk of chunked(businessIds, 30)) {
    const snapshot = await database
      .collection("bookings")
      .where("businessId", "in", businessIdsChunk)
      .where("status", "==", "confirmed")
      .where("checkIn", "<", checkOut)
      .where("checkOut", ">", checkIn)
      .get();
    bookings.push(...snapshot.docs.map((document) => document.data()));
  }
  return bookings;
}

export function applyStayCursor<T extends { startAfter: (...values: unknown[]) => T }>(
  query: T,
  cursor: StayCursor | null,
) {
  if (cursor == null) return query;
  return query.startAfter(
    cursor.averageRating,
    cursor.reviewCount,
    cursor.name,
    cursor.id,
  );
}

function chunked<T>(items: T[], size: number) {
  const chunks: T[][] = [];
  for (let index = 0; index < items.length; index += size) {
    chunks.push(items.slice(index, index + size));
  }
  return chunks;
}
