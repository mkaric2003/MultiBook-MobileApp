import type { Firestore } from "firebase-admin/firestore";

import type { ServiceDocument, ServiceSearchFilters } from "./search_service_types.js";

export async function loadServiceCandidates(
  database: Firestore,
  filters: ServiceSearchFilters,
) {
  let query = database
    .collection("businesses")
    .where("type", "==", "services")
    .where("isActive", "==", true);

  if (filters.city != null) {
    query = query.where("location.cityLowercase", "==", filters.city);
  }
  if (filters.categoryId != null) {
    query = query.where("categoryId", "==", filters.categoryId);
  }
  if (filters.collectionId != null) {
    query = query.where(
      "featuredCollectionIds",
      "array-contains",
      filters.collectionId,
    );
  }

  const snapshot = await query.get();
  return snapshot.docs.map<ServiceDocument>((document) => ({
    id: document.id,
    data: document.data(),
  }));
}

export async function loadDocumentsForBusinessesOnDate(
  database: Firestore,
  collection: string,
  businessIds: string[],
  dateKey: string,
  status?: string,
) {
  const result: Record<string, unknown>[] = [];
  for (const businessIdsChunk of chunked(businessIds, 30)) {
    let query = database
      .collection(collection)
      .where("businessId", "in", businessIdsChunk)
      .where("dateKey", "==", dateKey);
    if (status != null) {
      query = query.where("status", "==", status);
    }
    const snapshot = await query.get();
    result.push(...snapshot.docs.map((document) => document.data()));
  }
  return result;
}

function chunked<T>(items: T[], size: number) {
  const chunks: T[][] = [];
  for (let index = 0; index < items.length; index += size) {
    chunks.push(items.slice(index, index + size));
  }
  return chunks;
}
