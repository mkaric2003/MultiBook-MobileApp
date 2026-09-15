import { Timestamp } from "firebase-admin/firestore";

import { list, map, number } from "./search_service_filters.js";
import type { ServiceDocument } from "./search_service_types.js";

export function sortServices(
  services: ServiceDocument[],
  sortOption: string,
) {
  services.sort((first, second) => compare(first, second, sortOption));
}

export function pageServices(
  services: ServiceDocument[],
  cursor: string | null,
  pageSize: number,
) {
  const start = cursorIndex(services, cursor);
  const page = services.slice(start, start + pageSize);
  return {
    items: page.map(serializeService),
    nextCursor: start + pageSize < services.length
      ? page.at(-1)?.id ?? null
      : null,
  };
}

function compare(
  first: ServiceDocument,
  second: ServiceDocument,
  sortOption: string,
) {
  const firstPrice = lowestPrice(first);
  const secondPrice = lowestPrice(second);
  if (sortOption === "priceLowToHigh") {
    return firstPrice - secondPrice || nameCompare(first, second);
  }
  if (sortOption === "priceHighToLow") {
    return secondPrice - firstPrice || nameCompare(first, second);
  }
  const rating = number(second.data.averageRating) - number(first.data.averageRating);
  if (sortOption === "rating") return rating || nameCompare(first, second);
  return rating ||
    number(second.data.reviewCount) - number(first.data.reviewCount) ||
    nameCompare(first, second);
}

function lowestPrice(service: ServiceDocument) {
  return Math.min(
    ...list(map(service.data.serviceDetails).offerings).map((item) =>
      number(map(item).price),
    ),
    Number.MAX_SAFE_INTEGER,
  );
}

function nameCompare(first: ServiceDocument, second: ServiceDocument) {
  return String(first.data.name ?? "").localeCompare(
    String(second.data.name ?? ""),
  ) || first.id.localeCompare(second.id);
}

function cursorIndex(items: ServiceDocument[], cursor: string | null) {
  if (cursor == null) return 0;
  const index = items.findIndex((item) => item.id === cursor);
  return index < 0 ? 0 : index + 1;
}

function serializeService(service: ServiceDocument) {
  const data = service.data;
  return {
    id: service.id,
    ownerId: String(data.ownerId ?? ""),
    type: "services",
    name: String(data.name ?? ""),
    categoryId: String(data.categoryId ?? ""),
    location: clean(map(data.location)),
    shortDescription: data.shortDescription ?? null,
    logoUrl: data.logoUrl ?? null,
    coverPhotoUrl: data.coverPhotoUrl ?? null,
    photoUrls: cleanList(list(data.photoUrls)),
    featuredCollectionIds: cleanList(list(data.featuredCollectionIds)),
    isActive: true,
    averageRating: number(data.averageRating),
    reviewCount: number(data.reviewCount),
    serviceDetails: clean(map(data.serviceDetails)),
  };
}

function clean(value: Record<string, unknown>) {
  return Object.fromEntries(
    Object.entries(value).map(([key, item]) => [key, cleanValue(item)]),
  );
}

function cleanList(values: unknown[]) {
  return values.map(cleanValue);
}

function cleanValue(value: unknown): unknown {
  if (value instanceof Timestamp) return value.toDate().toISOString();
  if (value instanceof Date) return value.toISOString();
  if (Array.isArray(value)) return cleanList(value);
  if (value != null && typeof value === "object") {
    return clean(value as Record<string, unknown>);
  }
  return value;
}
