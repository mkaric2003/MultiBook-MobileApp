import { onDocumentCreated, onDocumentUpdated } from "firebase-functions/v2/firestore";

import { createAndDeliverNotification } from "./notification_dispatcher.js";
import { recordReservationCreated, recordReservationUpdated } from "../metrics/business_metrics.js";

export const notifyOnBookingCreated = onDocumentCreated(
  "bookings/{bookingId}",
  async (event) => {
    const booking = event.data?.data();
    if (booking == null) return;

    await Promise.all([
      createAndDeliverNotification({
      id: `booking_created_owner_${event.params.bookingId}`,
      recipientId: booking.businessOwnerId as string,
      kind: "booking_created",
      title: "New booking",
      body: `${booking.customerName as string} booked ${booking.businessName as string}.`,
      data: {
        type: "booking",
        bookingId: event.params.bookingId,
        businessId: booking.businessId as string,
      },
      }),
      recordReservationCreated("booking", booking),
    ]);
  },
);

export const notifyOnBookingStatusChanged = onDocumentUpdated(
  "bookings/{bookingId}",
  async (event) => {
    const before = event.data?.before.data();
    const after = event.data?.after.data();
    if (before == null || after == null || before.status === after.status) return;

    await Promise.all([
      createAndDeliverNotification({
      id: `booking_status_${event.params.bookingId}_${after.status as string}`,
      recipientId: after.customerId as string,
      kind: "booking_status_changed",
      title: "Booking updated",
      body: `Your booking at ${after.businessName as string} is now ${after.status as string}.`,
      data: {
        type: "booking",
        bookingId: event.params.bookingId,
        businessId: after.businessId as string,
      },
      }),
      recordReservationUpdated("booking", before, after),
    ]);
  },
);
