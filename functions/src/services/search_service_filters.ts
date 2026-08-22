import { HttpsError } from "firebase-functions/v2/https";

import type { ServiceDocument, ServiceSearchFilters, ServiceSearchRequest } from "./search_service_types.js";

const supportedSortOptions = new Set([
  "recommended",
  "priceLowToHigh",
  "priceHighToLow",
  "rating",
]);

export function parseServiceSearchFilters(
  data: ServiceSearchRequest,
): ServiceSearchFilters {
  return {
    date: parseDate(data.date),
    timeMinutes: asOptionalMinutes(data.timeMinutes),
    categoryId: normalizeIdentifier(data.categoryId),
    collectionId: normalizeIdentifier(data.collectionId),
    city: normalizeText(data.city),
    // UI filters use whole currency units; service offering prices in
    // Firestore are stored in minor units.
    minPrice: priceInMinorUnits(data.minPrice, 0),
    maxPrice: priceInMinorUnits(data.maxPrice, Number.MAX_SAFE_INTEGER),
    sortOption: supportedSortOptions.has(String(data.sortOption))
      ? String(data.sortOption)
      : "recommended",
    cursor: typeof data.cursor === "string" && data.cursor.length > 0
      ? data.cursor
      : null,
    pageSize: Math.min(20, Math.max(1, integer(data.pageSize, 8))),
  };
}

export function matchesServiceFilters(
  service: ServiceDocument,
  filters: ServiceSearchFilters,
) {
  const location = map(service.data.location);
  const offerings = list(map(service.data.serviceDetails).offerings).map(map);
  const collectionIds = list(service.data.featuredCollectionIds).map(String);
  return (filters.city == null || normalizeText(location.city) === filters.city) &&
    (filters.categoryId == null || String(service.data.categoryId ?? "") === filters.categoryId) &&
    (filters.collectionId == null || collectionIds.includes(filters.collectionId)) &&
    offerings.some((offering) => {
      const price = number(offering.price);
      return price >= filters.minPrice && price <= filters.maxPrice;
    });
}

export function map(value: unknown): Record<string, unknown> {
  return value != null && typeof value === "object" && !Array.isArray(value)
    ? value as Record<string, unknown>
    : {};
}

export function list(value: unknown): unknown[] {
  return Array.isArray(value) ? value : [];
}

export function number(value: unknown) {
  const parsed = Number(value);
  return Number.isFinite(parsed) ? parsed : 0;
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

function normalizeIdentifier(value: unknown) {
  if (typeof value !== "string") return null;
  const normalized = value.trim().toLowerCase();
  return normalized.length === 0 ? null : normalized;
}

export function dateKeyFor(date: Date) {
  return `${date.getUTCFullYear()}-${String(date.getUTCMonth() + 1).padStart(2, "0")}-${String(date.getUTCDate()).padStart(2, "0")}`;
}

function parseDate(value: unknown) {
  if (value == null) return null;
  if (typeof value !== "string") {
    throw new HttpsError("invalid-argument", "date must be an ISO date string.");
  }
  const date = new Date(value);
  if (Number.isNaN(date.valueOf())) {
    throw new HttpsError("invalid-argument", "date is invalid.");
  }
  return date;
}

function asOptionalMinutes(value: unknown) {
  if (value == null) return null;
  const minutes = Number(value);
  if (!Number.isInteger(minutes) || minutes < 0 || minutes >= 1440) {
    throw new HttpsError("invalid-argument", "timeMinutes is invalid.");
  }
  return minutes;
}

function integer(value: unknown, fallback: number) {
  const parsed = Number(value);
  return Number.isInteger(parsed) && parsed > 0 ? parsed : fallback;
}

function nonNegative(value: unknown, fallback: number) {
  const parsed = Number(value);
  return Number.isFinite(parsed) && parsed >= 0 ? parsed : fallback;
}

function priceInMinorUnits(value: unknown, fallback: number) {
  if (value == null) return fallback;
  const price = nonNegative(value, fallback);
  return Number.isSafeInteger(price * 100) ? Math.round(price * 100) : fallback;
}
