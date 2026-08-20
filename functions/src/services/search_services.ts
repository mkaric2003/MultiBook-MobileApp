import { getFirestore, Timestamp, type Firestore } from "firebase-admin/firestore";
import { HttpsError, onCall } from "firebase-functions/v2/https";

type RequestData = {
  date?: unknown; timeMinutes?: unknown; serviceName?: unknown; city?: unknown;
  minPrice?: unknown; maxPrice?: unknown; sortOption?: unknown; cursor?: unknown; pageSize?: unknown;
};
type ServiceDocument = { id: string; data: Record<string, unknown> };
const activeStatuses = new Set(["confirmed"]);

export const searchServices = onCall<RequestData>({ region: "us-central1" }, async (request) => {
  if (request.auth == null) throw new HttpsError("unauthenticated", "You need to sign in to search services.");
  const filters = parseFilters(request.data);
  const database = getFirestore();
  let services = (await database.collection("businesses").where("type", "==", "services").where("isActive", "==", true).get())
    .docs.map((document) => ({ id: document.id, data: document.data() }));
  services = services.filter((service) => matches(service, filters));
  if (filters.date != null && filters.timeMinutes != null) {
    const [appointments, bookedSlots, blocks] = await Promise.all([
      loadDocuments(database, "appointments", services.map((service) => service.id)),
      loadDocuments(database, "appointment_slots", services.map((service) => service.id)),
      loadDocuments(database, "service_availability_blocks", services.map((service) => service.id)),
    ]);
    services = services.filter((service) => hasAvailableProvider(service, appointments, bookedSlots, blocks, filters));
  }
  services.sort((first, second) => compare(first, second, filters.sortOption));
  const start = cursorIndex(services, filters.cursor);
  const page = services.slice(start, start + filters.pageSize);
  return { items: page.map(serialize), nextCursor: start + filters.pageSize < services.length ? page.at(-1)?.id ?? null : null };
});

function parseFilters(data: RequestData) {
  const date = parseDate(data.date);
  const timeMinutes = asOptionalMinutes(data.timeMinutes);
  return {
    date, timeMinutes, city: normalize(data.city), serviceName: normalize(data.serviceName),
    minPrice: nonNegative(data.minPrice, 0), maxPrice: nonNegative(data.maxPrice, Number.MAX_SAFE_INTEGER),
    sortOption: ["recommended", "priceLowToHigh", "priceHighToLow", "rating"].includes(String(data.sortOption)) ? String(data.sortOption) : "recommended",
    cursor: typeof data.cursor === "string" && data.cursor.length > 0 ? data.cursor : null,
    pageSize: Math.min(20, Math.max(1, integer(data.pageSize, 8))),
  };
}

function matches(service: ServiceDocument, filters: ReturnType<typeof parseFilters>) {
  const location = map(service.data.location);
  const offerings = list(map(service.data.serviceDetails).offerings).map(map);
  return (filters.city == null || normalize(location.city) === filters.city) &&
    offerings.some((offering) => {
      const name = normalize(offering.name) ?? "";
      const price = number(offering.price);
      return (filters.serviceName == null || name.includes(filters.serviceName)) && price >= filters.minPrice && price <= filters.maxPrice;
    });
}

function hasAvailableProvider(service: ServiceDocument, appointments: Record<string, unknown>[], bookedSlots: Record<string, unknown>[], blocks: Record<string, unknown>[], filters: ReturnType<typeof parseFilters>) {
  const details = map(service.data.serviceDetails);
  const offerings = list(details.offerings).map(map).filter((offering) => filters.serviceName == null || (normalize(offering.name) ?? "").includes(filters.serviceName!));
  const weekday = weekdayName(filters.date!);
  const dateKey = dateKeyFor(filters.date!);
  const providers = list(details.providers).map(map);
  const effectiveProviders = providers.length > 0 ? providers : [map(details.provider)];

  return effectiveProviders.some((provider) => {
    const providerId = String(provider.id ?? "legacy-provider");
    const slots = list(provider.availabilitySlots ?? details.availabilitySlots).map(map);

    return offerings.some((offering) => {
      const duration = Math.max(30, number(offering.durationMinutes));
      const end = filters.timeMinutes! + duration;
      const withinHours = slots.some(
        (slot) =>
          normalize(slot.weekday) === weekday &&
          filters.timeMinutes! >= number(slot.startMinutes) &&
          end <= number(slot.endMinutes),
      );
      if (!withinHours) return false;

      const requiredSlotStarts = slotStarts(filters.timeMinutes!, end);
      const hasBookedSlot = bookedSlots.some(
        (slot) =>
          slot.businessId === service.id &&
          slot.providerId === providerId &&
          slot.dateKey === dateKey &&
          requiredSlotStarts.has(number(slot.startMinutes)),
      );
      const hasBlockedSlot = blocks.some(
        (block) =>
          block.businessId === service.id &&
          block.providerId === providerId &&
          block.dateKey === dateKey &&
          requiredSlotStarts.has(number(block.startMinutes)),
      );
      const hasAppointment = appointments.some(
        (appointment) =>
          appointment.businessId === service.id &&
          appointment.providerId === providerId &&
          activeStatuses.has(String(appointment.status)) &&
          sameDate(toDate(appointment.date), filters.date!) &&
          number(appointment.startMinutes) < end &&
          number(appointment.endMinutes) > filters.timeMinutes!,
      );
      return !hasBookedSlot && !hasBlockedSlot && !hasAppointment;
    });
  });
}

async function loadDocuments(database: Firestore, collection: string, ids: string[]) {
  const result: Record<string, unknown>[] = [];
  for (let index = 0; index < ids.length; index += 30) {
    const chunk = ids.slice(index, index + 30);
    if (chunk.length === 0) continue;
    const snapshot = await database.collection(collection).where("businessId", "in", chunk).get();
    result.push(...snapshot.docs.map((document) => document.data()));
  }
  return result;
}

function compare(first: ServiceDocument, second: ServiceDocument, sort: string) {
  const firstPrice = lowestPrice(first); const secondPrice = lowestPrice(second);
  if (sort === "priceLowToHigh") return firstPrice - secondPrice || nameCompare(first, second);
  if (sort === "priceHighToLow") return secondPrice - firstPrice || nameCompare(first, second);
  const rating = number(second.data.averageRating) - number(first.data.averageRating);
  if (sort === "rating") return rating || nameCompare(first, second);
  return rating || number(second.data.reviewCount) - number(first.data.reviewCount) || nameCompare(first, second);
}
function lowestPrice(service: ServiceDocument) { return Math.min(...list(map(service.data.serviceDetails).offerings).map((item) => number(map(item).price)), Number.MAX_SAFE_INTEGER); }
function nameCompare(first: ServiceDocument, second: ServiceDocument) { return String(first.data.name ?? "").localeCompare(String(second.data.name ?? "")) || first.id.localeCompare(second.id); }
function serialize(service: ServiceDocument) { const data = service.data; return { id: service.id, ownerId: String(data.ownerId ?? ""), type: "services", name: String(data.name ?? ""), categoryId: String(data.categoryId ?? ""), location: clean(map(data.location)), shortDescription: data.shortDescription ?? null, logoUrl: data.logoUrl ?? null, coverPhotoUrl: data.coverPhotoUrl ?? null, photoUrls: cleanList(list(data.photoUrls)), isActive: true, averageRating: number(data.averageRating), reviewCount: number(data.reviewCount), serviceDetails: clean(map(data.serviceDetails)) }; }
function cursorIndex(items: ServiceDocument[], cursor: string | null) { if (cursor == null) return 0; const index = items.findIndex((item) => item.id === cursor); return index < 0 ? 0 : index + 1; }
function parseDate(value: unknown) { if (value == null) return null; if (typeof value !== "string") throw new HttpsError("invalid-argument", "date must be an ISO date string."); const date = new Date(value); if (Number.isNaN(date.valueOf())) throw new HttpsError("invalid-argument", "date is invalid."); return date; }
function asOptionalMinutes(value: unknown) { if (value == null) return null; const minutes = Number(value); if (!Number.isInteger(minutes) || minutes < 0 || minutes >= 1440) throw new HttpsError("invalid-argument", "timeMinutes is invalid."); return minutes; }
function integer(value: unknown, fallback: number) { const parsed = Number(value); return Number.isInteger(parsed) && parsed > 0 ? parsed : fallback; }
function nonNegative(value: unknown, fallback: number) { const parsed = Number(value); return Number.isFinite(parsed) && parsed >= 0 ? parsed : fallback; }
function normalize(value: unknown) { if (typeof value !== "string") return null; const normalized = value.trim().toLowerCase(); return normalized.length === 0 ? null : normalized; }
function map(value: unknown): Record<string, unknown> { return value != null && typeof value === "object" && !Array.isArray(value) ? value as Record<string, unknown> : {}; }
function list(value: unknown): unknown[] { return Array.isArray(value) ? value : []; }
function number(value: unknown) { const parsed = Number(value); return Number.isFinite(parsed) ? parsed : 0; }
function toDate(value: unknown) { if (value instanceof Timestamp) return value.toDate(); if (value instanceof Date) return value; if (typeof value === "string") { const date = new Date(value); return Number.isNaN(date.valueOf()) ? null : date; } return null; }
function sameDate(first: Date | null, second: Date) { return first != null && first.getUTCFullYear() === second.getUTCFullYear() && first.getUTCMonth() === second.getUTCMonth() && first.getUTCDate() === second.getUTCDate(); }
function weekdayName(date: Date) { return ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"][date.getUTCDay()]; }
function dateKeyFor(date: Date) { return `${date.getUTCFullYear()}-${String(date.getUTCMonth() + 1).padStart(2, "0")}-${String(date.getUTCDate()).padStart(2, "0")}`; }
function slotStarts(start: number, end: number) { const starts = new Set<number>(); for (let slot = start; slot < end; slot += 30) starts.add(slot); return starts; }
function clean(value: Record<string, unknown>) { return Object.fromEntries(Object.entries(value).map(([key, item]) => [key, cleanValue(item)])); }
function cleanList(values: unknown[]) { return values.map(cleanValue); }
function cleanValue(value: unknown): unknown { if (value instanceof Timestamp) return value.toDate().toISOString(); if (value instanceof Date) return value.toISOString(); if (Array.isArray(value)) return cleanList(value); if (value != null && typeof value === "object") return clean(value as Record<string, unknown>); return value; }
