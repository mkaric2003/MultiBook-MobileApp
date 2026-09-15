import { getFirestore, type Firestore } from "firebase-admin/firestore";
import { HttpsError, onCall } from "firebase-functions/v2/https";

import { filterAvailableStays } from "./search_stay_availability.js";
import {
  applyStayCursor,
  createStayCandidateQuery,
  stayCandidateBatchSize,
} from "./search_stay_documents.js";
import {
  matchesStayFilters,
  parseStaySearchFilters,
} from "./search_stay_filters.js";
import {
  decodeStayCursor,
  encodeStayCursor,
  serializeStay,
} from "./search_stay_response.js";
import type { StaySearchFilters, StaySearchRequest } from "./search_stay_types.js";

export const searchStays = onCall<StaySearchRequest>(
  { region: "us-central1" },
  async (request) => {
    if (request.auth == null) {
      throw new HttpsError("unauthenticated", "You need to sign in to search stays.");
    }

    try {
      return await loadStayPage(
        getFirestore(),
        parseStaySearchFilters(request.data),
      );
    } catch (error) {
      console.error("[searchStays] Request failed.", error);
      if (error instanceof HttpsError) throw error;
      throw new HttpsError(
        "internal",
        "Unable to search stays. Please try again.",
      );
    }
  },
);

async function loadStayPage(
  database: Firestore,
  filters: StaySearchFilters,
) {
  let query = applyStayCursor(
    createStayCandidateQuery(database, filters),
    decodeStayCursor(filters.cursor),
  );
  const items: Record<string, unknown>[] = [];

  while (items.length < filters.pageSize) {
    const snapshot = await query.limit(stayCandidateBatchSize).get();
    if (snapshot.docs.length === 0) return { items, nextCursor: null };

    const candidates = snapshot.docs.map((document) => ({
      id: document.id,
      data: document.data(),
    }));
    const staticMatches = candidates.filter((stay) =>
      matchesStayFilters(stay, filters),
    );
    const availableStays = await filterAvailableStays(
      database,
      staticMatches,
      filters,
    );
    const matchesById = new Map(availableStays.map((stay) => [stay.id, stay]));

    for (const document of snapshot.docs) {
      const stay = matchesById.get(document.id);
      if (stay == null) continue;

      items.push(serializeStay(stay));
      if (items.length === filters.pageSize) {
        const hasMore = document !== snapshot.docs.at(-1) ||
          snapshot.docs.length === stayCandidateBatchSize;
        return {
          items,
          nextCursor: hasMore ? encodeStayCursor(document.id, document.data()) : null,
        };
      }
    }

    if (snapshot.docs.length < stayCandidateBatchSize) {
      return { items, nextCursor: null };
    }
    query = query.startAfter(snapshot.docs.at(-1)!);
  }

  return { items, nextCursor: null };
}
