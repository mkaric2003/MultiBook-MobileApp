import {
  FieldValue,
  Timestamp,
  getFirestore,
  type DocumentData,
} from "firebase-admin/firestore";
import { HttpsError, onCall } from "firebase-functions/v2/https";

type ReservationKind = "booking" | "appointment";

const activeStatuses = new Set(["confirmed"]);
const revenueStatuses = new Set(["confirmed", "completed"]);
const metricsVersion = 4;

export const initializeBusinessMetrics = onCall<{ businessId?: unknown }>(
  { region: "us-central1" },
  async (request) => {
    const businessId = stringValue(request.data.businessId);
    if (request.auth == null) {
      throw new HttpsError("unauthenticated", "You need to sign in.");
    }
    if (businessId == null) {
      throw new HttpsError("invalid-argument", "businessId is required.");
    }

    const database = getFirestore();
    const [business, summary, bookings, appointments] = await Promise.all([
      database.collection("businesses").doc(businessId).get(),
      database.collection("business_metrics").doc(businessId).get(),
      database.collection("bookings").where("businessId", "==", businessId).get(),
      database.collection("appointments").where("businessId", "==", businessId).get(),
    ]);
    if (!business.exists) {
      throw new HttpsError("not-found", "Business not found.");
    }
    if (business.data()?.ownerId !== request.auth.uid) {
      throw new HttpsError("permission-denied", "You cannot initialize these metrics.");
    }
    if (summary.exists && summary.data()?.metricsVersion === metricsVersion) {
      const currentMonth = await database
          .collection("business_metrics")
          .doc(businessId)
          .collection("months")
          .doc(formatMonthKey(new Date()))
          .get();
      const data = currentMonth.data();
      if (
        data == null ||
        (typeof data.onlineEarnings === "number" &&
          typeof data.cashEarnings === "number")
      ) {
        return { initialized: false };
      }
    }

    const metrics = aggregateMetrics([
      ...bookings.docs.map((document) => ({ kind: "booking" as const, data: document.data() })),
      ...appointments.docs.map((document) => ({ kind: "appointment" as const, data: document.data() })),
    ]);
    const providerMetrics = aggregateProviderMetrics(
      appointments.docs.map((document) => document.data()),
    );
    const batch = database.batch();
    const summaryReference = database.collection("business_metrics").doc(businessId);
    batch.set(summaryReference, {
      businessId,
      metricsVersion,
      activeBookings: metrics.activeBookings,
      activeAppointments: metrics.activeAppointments,
      updatedAt: FieldValue.serverTimestamp(),
    });
    for (const [monthKey, month] of metrics.months) {
      batch.set(summaryReference.collection("months").doc(monthKey), {
        monthKey,
        metricsVersion,
        revenue: month.revenue,
        bookingCount: month.bookingCount,
        onlineEarnings: month.onlineEarnings,
        cashEarnings: month.cashEarnings,
        dailyRevenue: month.dailyRevenue,
        dailyBookings: month.dailyBookings,
        dailyOnlineEarnings: month.dailyOnlineEarnings,
        dailyCashEarnings: month.dailyCashEarnings,
        updatedAt: FieldValue.serverTimestamp(),
      });
    }
    for (const [providerId, provider] of providerMetrics) {
      const providerReference = summaryReference.collection("providers").doc(providerId);
      batch.set(providerReference, {
        providerId,
        providerName: provider.name,
        updatedAt: FieldValue.serverTimestamp(),
      });
      for (const [monthKey, month] of provider.months) {
        batch.set(providerReference.collection("months").doc(monthKey), {
          monthKey,
          grossRevenue: month.grossRevenue,
          providerEarnings: month.providerEarnings,
          appointmentCount: month.appointmentCount,
          dailyGrossRevenue: month.dailyGrossRevenue,
          dailyProviderEarnings: month.dailyProviderEarnings,
          dailyAppointments: month.dailyAppointments,
          updatedAt: FieldValue.serverTimestamp(),
        });
      }
    }
    await batch.commit();
    return { initialized: true };
  },
);

export async function recordReservationCreated(
  kind: ReservationKind,
  reservation: DocumentData,
) {
  await applyReservationChange(kind, null, reservation);
}

export async function recordReservationUpdated(
  kind: ReservationKind,
  before: DocumentData,
  after: DocumentData,
) {
  await applyReservationChange(kind, before, after);
}

async function applyReservationChange(
  kind: ReservationKind,
  before: DocumentData | null,
  after: DocumentData | null,
) {
  const businessId = stringValue(after?.businessId ?? before?.businessId);
  if (businessId == null) return;

  const activeDelta = activeContribution(after) - activeContribution(before);
  const beforeRevenue = revenueContribution(before);
  const afterRevenue = revenueContribution(after);
  const database = getFirestore();
  const summaryReference = database.collection("business_metrics").doc(businessId);

  await database.runTransaction(async (transaction) => {
    const summarySnapshot = await transaction.get(summaryReference);
    const summary = summarySnapshot.data() ?? {};
    const activeField = kind === "booking" ? "activeBookings" : "activeAppointments";
    const nextActive = Math.max(0, numberValue(summary[activeField]) + activeDelta);

    const monthlyDeltas = createMonthlyDeltas(before, -beforeRevenue);
    mergeMonthlyDeltas(monthlyDeltas, createMonthlyDeltas(after, afterRevenue));
    const entries = [...monthlyDeltas.entries()];
    const monthSnapshots = await Promise.all(
      entries.map(([monthKey]) =>
        transaction.get(
          database
            .collection("business_metrics")
            .doc(businessId)
            .collection("months")
            .doc(monthKey),
        ),
      ),
    );
    transaction.set(
      summaryReference,
      {
        businessId,
        metricsVersion,
        [activeField]: nextActive,
        updatedAt: FieldValue.serverTimestamp(),
      },
      { merge: true },
    );
    for (var index = 0; index < entries.length; index++) {
      const [monthKey, delta] = entries[index]!;
      const month = monthSnapshots[index]!.data() ?? {};
      const dailyRevenue = mapOfNumbers(month.dailyRevenue);
      const dailyBookings = mapOfNumbers(month.dailyBookings);
      const dailyOnlineEarnings = mapOfNumbers(month.dailyOnlineEarnings);
      const dailyCashEarnings = mapOfNumbers(month.dailyCashEarnings);
      dailyRevenue[delta.dayKey] = Math.max(
        0,
        (dailyRevenue[delta.dayKey] ?? 0) + delta.revenue,
      );
      dailyBookings[delta.dayKey] = Math.max(
        0,
        (dailyBookings[delta.dayKey] ?? 0) + delta.count,
      );
      dailyOnlineEarnings[delta.dayKey] = Math.max(
        0,
        (dailyOnlineEarnings[delta.dayKey] ?? 0) + delta.onlineEarnings,
      );
      dailyCashEarnings[delta.dayKey] = Math.max(
        0,
        (dailyCashEarnings[delta.dayKey] ?? 0) + delta.cashEarnings,
      );
      transaction.set(
        database
            .collection("business_metrics")
            .doc(businessId)
            .collection("months")
            .doc(monthKey),
        {
          monthKey,
          revenue: Math.max(0, numberValue(month.revenue) + delta.revenue),
          bookingCount: Math.max(
            0,
            numberValue(month.bookingCount) + delta.count,
          ),
          onlineEarnings: Math.max(
            0,
            numberValue(month.onlineEarnings) + delta.onlineEarnings,
          ),
          cashEarnings: Math.max(
            0,
            numberValue(month.cashEarnings) + delta.cashEarnings,
          ),
          dailyRevenue,
          dailyBookings,
          dailyOnlineEarnings,
          dailyCashEarnings,
          updatedAt: FieldValue.serverTimestamp(),
        },
        { merge: true },
      );
    }
  });

  if (kind === "appointment") {
    await applyProviderMetrics(businessId, before, after);
  }
}

async function applyProviderMetrics(
  businessId: string,
  before: DocumentData | null,
  after: DocumentData | null,
) {
  const providerId = stringValue(after?.providerId ?? before?.providerId);
  if (providerId == null) return;

  const grossBefore = revenueContribution(before);
  const grossAfter = revenueContribution(after);
  const earningsBefore = providerEarningsContribution(before);
  const earningsAfter = providerEarningsContribution(after);
  const deltas = createProviderMonthlyDeltas(before, -grossBefore, -earningsBefore);
  mergeProviderMonthlyDeltas(
    deltas,
    createProviderMonthlyDeltas(after, grossAfter, earningsAfter),
  );
  if (deltas.size === 0) return;

  const database = getFirestore();
  const providerReference = database
      .collection("business_metrics")
      .doc(businessId)
      .collection("providers")
      .doc(providerId);
  await database.runTransaction(async (transaction) => {
    const entries = [...deltas.entries()];
    const snapshots = await Promise.all(
      entries.map(([monthKey]) => transaction.get(providerReference.collection("months").doc(monthKey))),
    );
    transaction.set(
      providerReference,
      {
        providerId,
        providerName: stringValue(after?.providerName ?? before?.providerName) ?? "",
        updatedAt: FieldValue.serverTimestamp(),
      },
      { merge: true },
    );
    for (let index = 0; index < entries.length; index++) {
      const [monthKey, delta] = entries[index]!;
      const month = snapshots[index]!.data() ?? {};
      const dailyGrossRevenue = mapOfNumbers(month.dailyGrossRevenue);
      const dailyProviderEarnings = mapOfNumbers(month.dailyProviderEarnings);
      const dailyAppointments = mapOfNumbers(month.dailyAppointments);
      dailyGrossRevenue[delta.dayKey] = Math.max(
        0,
        (dailyGrossRevenue[delta.dayKey] ?? 0) + delta.grossRevenue,
      );
      dailyProviderEarnings[delta.dayKey] = Math.max(
        0,
        (dailyProviderEarnings[delta.dayKey] ?? 0) + delta.providerEarnings,
      );
      dailyAppointments[delta.dayKey] = Math.max(
        0,
        (dailyAppointments[delta.dayKey] ?? 0) + delta.count,
      );
      transaction.set(
        providerReference.collection("months").doc(monthKey),
        {
          monthKey,
          grossRevenue: Math.max(0, numberValue(month.grossRevenue) + delta.grossRevenue),
          providerEarnings: Math.max(
            0,
            numberValue(month.providerEarnings) + delta.providerEarnings,
          ),
          appointmentCount: Math.max(
            0,
            numberValue(month.appointmentCount) + delta.count,
          ),
          dailyGrossRevenue,
          dailyProviderEarnings,
          dailyAppointments,
          updatedAt: FieldValue.serverTimestamp(),
        },
        { merge: true },
      );
    }
  });
}

interface MonthlyDelta {
  dayKey: string;
  revenue: number;
  count: number;
  onlineEarnings: number;
  cashEarnings: number;
}

interface ProviderMonthlyDelta {
  dayKey: string;
  grossRevenue: number;
  providerEarnings: number;
  count: number;
}

interface AggregateMonth {
  revenue: number;
  bookingCount: number;
  onlineEarnings: number;
  cashEarnings: number;
  dailyRevenue: Record<string, number>;
  dailyBookings: Record<string, number>;
  dailyOnlineEarnings: Record<string, number>;
  dailyCashEarnings: Record<string, number>;
}

interface ProviderAggregateMonth {
  grossRevenue: number;
  providerEarnings: number;
  appointmentCount: number;
  dailyGrossRevenue: Record<string, number>;
  dailyProviderEarnings: Record<string, number>;
  dailyAppointments: Record<string, number>;
}

interface ProviderAggregate {
  name: string;
  months: Map<string, ProviderAggregateMonth>;
}

function aggregateMetrics(
  reservations: { kind: ReservationKind; data: DocumentData }[],
) {
  let activeBookings = 0;
  let activeAppointments = 0;
  const months = new Map<string, AggregateMonth>();
  for (const reservation of reservations) {
    if (activeContribution(reservation.data) > 0) {
      if (reservation.kind === "booking") activeBookings++;
      else activeAppointments++;
    }
    const revenue = revenueContribution(reservation.data);
    if (revenue === 0) continue;
    const date = dateValue(reservation.data.createdAt) ?? new Date();
    const monthKey = formatMonthKey(date);
    const dayKey = formatDayKey(date);
    const month = months.get(monthKey) ?? {
      revenue: 0,
      bookingCount: 0,
      onlineEarnings: 0,
      cashEarnings: 0,
      dailyRevenue: {},
      dailyBookings: {},
      dailyOnlineEarnings: {},
      dailyCashEarnings: {},
    };
    month.revenue += revenue;
    month.bookingCount++;
    if (isCashPayment(reservation.data)) month.cashEarnings += revenue;
    else month.onlineEarnings += revenue;
    month.dailyRevenue[dayKey] = (month.dailyRevenue[dayKey] ?? 0) + revenue;
    month.dailyBookings[dayKey] = (month.dailyBookings[dayKey] ?? 0) + 1;
    if (isCashPayment(reservation.data)) {
      month.dailyCashEarnings[dayKey] =
        (month.dailyCashEarnings[dayKey] ?? 0) + revenue;
    } else {
      month.dailyOnlineEarnings[dayKey] =
        (month.dailyOnlineEarnings[dayKey] ?? 0) + revenue;
    }
    months.set(monthKey, month);
  }
  return { activeBookings, activeAppointments, months };
}

function aggregateProviderMetrics(appointments: DocumentData[]) {
  const providers = new Map<string, ProviderAggregate>();
  for (const appointment of appointments) {
    const providerId = stringValue(appointment.providerId);
    const grossRevenue = revenueContribution(appointment);
    if (providerId == null || grossRevenue === 0) continue;
    const provider = providers.get(providerId) ?? {
      name: stringValue(appointment.providerName) ?? "",
      months: new Map<string, ProviderAggregateMonth>(),
    };
    const date = dateValue(appointment.createdAt) ?? new Date();
    const monthKey = formatMonthKey(date);
    const dayKey = formatDayKey(date);
    const month = provider.months.get(monthKey) ?? {
      grossRevenue: 0,
      providerEarnings: 0,
      appointmentCount: 0,
      dailyGrossRevenue: {},
      dailyProviderEarnings: {},
      dailyAppointments: {},
    };
    const providerEarnings = providerEarningsContribution(appointment);
    month.grossRevenue += grossRevenue;
    month.providerEarnings += providerEarnings;
    month.appointmentCount++;
    month.dailyGrossRevenue[dayKey] =
      (month.dailyGrossRevenue[dayKey] ?? 0) + grossRevenue;
    month.dailyProviderEarnings[dayKey] =
      (month.dailyProviderEarnings[dayKey] ?? 0) + providerEarnings;
    month.dailyAppointments[dayKey] =
      (month.dailyAppointments[dayKey] ?? 0) + 1;
    provider.months.set(monthKey, month);
    providers.set(providerId, provider);
  }
  return providers;
}

function createMonthlyDeltas(
  reservation: DocumentData | null,
  revenueDelta: number,
) {
  const deltas = new Map<string, MonthlyDelta>();
  if (reservation == null || revenueDelta === 0) return deltas;
  const createdAt = dateValue(reservation.createdAt) ?? new Date();
  const monthKey = formatMonthKey(createdAt);
  const dayKey = formatDayKey(createdAt);
  deltas.set(monthKey, {
    dayKey,
    revenue: revenueDelta,
    count: revenueDelta > 0 ? 1 : -1,
    onlineEarnings: isCashPayment(reservation) ? 0 : revenueDelta,
    cashEarnings: isCashPayment(reservation) ? revenueDelta : 0,
  });
  return deltas;
}

function createProviderMonthlyDeltas(
  reservation: DocumentData | null,
  grossDelta: number,
  providerEarningsDelta: number,
) {
  const deltas = new Map<string, ProviderMonthlyDelta>();
  if (reservation == null || (grossDelta === 0 && providerEarningsDelta === 0)) {
    return deltas;
  }
  const createdAt = dateValue(reservation.createdAt) ?? new Date();
  const monthKey = formatMonthKey(createdAt);
  deltas.set(monthKey, {
    dayKey: formatDayKey(createdAt),
    grossRevenue: grossDelta,
    providerEarnings: providerEarningsDelta,
    count: grossDelta > 0 ? 1 : -1,
  });
  return deltas;
}

function mergeMonthlyDeltas(
  target: Map<string, MonthlyDelta>,
  source: Map<string, MonthlyDelta>,
) {
  for (const [monthKey, delta] of source) {
    const current = target.get(monthKey);
    if (current == null) {
      target.set(monthKey, delta);
      continue;
    }
    current.revenue += delta.revenue;
    current.count += delta.count;
    current.onlineEarnings += delta.onlineEarnings;
    current.cashEarnings += delta.cashEarnings;
  }
}

function mergeProviderMonthlyDeltas(
  target: Map<string, ProviderMonthlyDelta>,
  source: Map<string, ProviderMonthlyDelta>,
) {
  for (const [monthKey, delta] of source) {
    const current = target.get(monthKey);
    if (current == null) {
      target.set(monthKey, delta);
      continue;
    }
    current.grossRevenue += delta.grossRevenue;
    current.providerEarnings += delta.providerEarnings;
    current.count += delta.count;
  }
}

function activeContribution(reservation: DocumentData | null) {
  return reservation != null && activeStatuses.has(stringValue(reservation.status) ?? "")
    ? 1
    : 0;
}

function revenueContribution(reservation: DocumentData | null) {
  if (reservation == null) return 0;
  if (isCashPayment(reservation)) {
    return revenueStatuses.has(stringValue(reservation.status) ?? "")
      ? numberValue(reservation.total)
      : 0;
  }
  if (!revenueStatuses.has(stringValue(reservation.status) ?? "")) return 0;
  if (stringValue(reservation.paymentStatus) !== "paid") return 0;
  return numberValue(reservation.total);
}

function providerEarningsContribution(reservation: DocumentData | null) {
  return revenueContribution(reservation) === 0
    ? 0
    : numberValue(reservation?.providerEarnings);
}

function isCashPayment(reservation: DocumentData | null) {
  return (
    stringValue(reservation?.paymentType) === "cash" ||
    stringValue(reservation?.paymentMethod)?.toLowerCase() === "cash"
  );
}

function numberValue(value: unknown) {
  return typeof value === "number" && Number.isFinite(value) ? value : 0;
}

function stringValue(value: unknown) {
  return typeof value === "string" && value.length > 0 ? value : null;
}

function dateValue(value: unknown) {
  if (value instanceof Timestamp) return value.toDate();
  if (value instanceof Date) return value;
  if (typeof value === "string" || typeof value === "number") {
    const parsed = new Date(value);
    return Number.isNaN(parsed.getTime()) ? null : parsed;
  }
  return null;
}

function mapOfNumbers(value: unknown): Record<string, number> {
  if (typeof value !== "object" || value == null || Array.isArray(value)) return {};
  return Object.fromEntries(
    Object.entries(value).flatMap(([key, item]) =>
      typeof item === "number" && Number.isFinite(item) ? [[key, item]] : [],
    ),
  );
}

function formatMonthKey(date: Date) {
  return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, "0")}`;
}

function formatDayKey(date: Date) {
  return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, "0")}-${String(date.getDate()).padStart(2, "0")}`;
}
