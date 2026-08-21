import type { Firestore } from "firebase-admin/firestore";

import {
  dateKeyFor,
  list,
  map,
  normalizeText,
  number,
} from "./search_service_filters.js";
import { loadDocumentsForBusinessesOnDate } from "./search_service_documents.js";
import type { ServiceDocument, ServiceSearchFilters } from "./search_service_types.js";

export async function filterServicesWithAvailability(
  database: Firestore,
  services: ServiceDocument[],
  filters: ServiceSearchFilters,
) {
  if (filters.date == null || filters.timeMinutes == null || services.length === 0) {
    return services;
  }

  const businessIds = services.map((service) => service.id);
  const dateKey = dateKeyFor(filters.date);
  const [appointments, bookedSlots, blocks] = await Promise.all([
    loadDocumentsForBusinessesOnDate(
      database,
      "appointments",
      businessIds,
      dateKey,
      "confirmed",
    ),
    loadDocumentsForBusinessesOnDate(
      database,
      "appointment_slots",
      businessIds,
      dateKey,
    ),
    loadDocumentsForBusinessesOnDate(
      database,
      "service_availability_blocks",
      businessIds,
      dateKey,
    ),
  ]);

  return services.filter((service) =>
    hasAvailableProvider(service, appointments, bookedSlots, blocks, filters),
  );
}

function hasAvailableProvider(
  service: ServiceDocument,
  appointments: Record<string, unknown>[],
  bookedSlots: Record<string, unknown>[],
  blocks: Record<string, unknown>[],
  filters: ServiceSearchFilters,
) {
  const details = map(service.data.serviceDetails);
  const offerings = list(details.offerings).map(map);
  const weekday = weekdayName(filters.date!);
  const dateKey = dateKeyFor(filters.date!);
  const providers = list(details.providers).map(map);
  const effectiveProviders = providers.length > 0
    ? providers
    : [map(details.provider)];

  return effectiveProviders.some((provider) => {
    const providerId = String(provider.id ?? "legacy-provider");
    const slots = list(provider.availabilitySlots ?? details.availabilitySlots).map(map);

    return offerings.some((offering) => {
      const duration = Math.max(30, number(offering.durationMinutes));
      const end = filters.timeMinutes! + duration;
      const withinHours = slots.some(
        (slot) =>
          normalizeText(slot.weekday) === weekday &&
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
          number(appointment.startMinutes) < end &&
          number(appointment.endMinutes) > filters.timeMinutes!,
      );
      return !hasBookedSlot && !hasBlockedSlot && !hasAppointment;
    });
  });
}

function weekdayName(date: Date) {
  return [
    "sunday",
    "monday",
    "tuesday",
    "wednesday",
    "thursday",
    "friday",
    "saturday",
  ][date.getUTCDay()];
}

function slotStarts(start: number, end: number) {
  const starts = new Set<number>();
  for (let slot = start; slot < end; slot += 30) starts.add(slot);
  return starts;
}
