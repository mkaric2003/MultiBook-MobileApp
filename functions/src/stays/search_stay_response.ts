import { Timestamp } from "firebase-admin/firestore";

import { asList, asMap, asNumber } from "./search_stay_filters.js";
import type { StayCursor, StayDocument } from "./search_stay_types.js";

export function serializeStay(stay: StayDocument) {
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
    featuredCollectionIds: sanitizeList(asList(data.featuredCollectionIds)),
    isActive: true,
    averageRating: asNumber(data.averageRating),
    reviewCount: asNumber(data.reviewCount),
    stayDetails: sanitizeMap(asMap(data.stayDetails)),
  };
}

export function encodeStayCursor(id: string, data: Record<string, unknown>) {
  return Buffer.from(
    JSON.stringify({
      id,
      averageRating: asNumber(data.averageRating),
      reviewCount: asNumber(data.reviewCount),
      name: String(data.name ?? ""),
    }),
  ).toString("base64url");
}

export function decodeStayCursor(value: string | null): StayCursor | null {
  if (value == null) return null;
  try {
    const parsed = JSON.parse(
      Buffer.from(value, "base64url").toString("utf8"),
    ) as Record<string, unknown>;
    if (typeof parsed.id !== "string" || typeof parsed.name !== "string") return null;
    return {
      id: parsed.id,
      name: parsed.name,
      averageRating: asNumber(parsed.averageRating),
      reviewCount: asNumber(parsed.reviewCount),
    };
  } catch (_) {
    return null;
  }
}

function sanitizeMap(map: Record<string, unknown>) {
  return Object.fromEntries(
    Object.entries(map).map(([key, value]) => [key, sanitizeValue(value)]),
  );
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
