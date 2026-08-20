import { onDocumentCreated, onDocumentUpdated } from "firebase-functions/v2/firestore";

import { createAndDeliverNotification } from "./notification_dispatcher.js";

export const notifyOnAppointmentCreated = onDocumentCreated(
  "appointments/{appointmentId}",
  async (event) => {
    const appointment = event.data?.data();
    if (appointment == null) return;

    await createAndDeliverNotification({
      id: `appointment_created_owner_${event.params.appointmentId}`,
      recipientId: appointment.businessOwnerId as string,
      kind: "appointment_created",
      title: "New appointment",
      body: `${appointment.customerName as string} booked ${appointment.businessName as string}.`,
      data: {
        type: "appointment",
        appointmentId: event.params.appointmentId,
        businessId: appointment.businessId as string,
      },
    });
  },
);

export const notifyOnAppointmentStatusChanged = onDocumentUpdated(
  "appointments/{appointmentId}",
  async (event) => {
    const before = event.data?.before.data();
    const after = event.data?.after.data();
    if (before == null || after == null || before.status === after.status) return;

    await createAndDeliverNotification({
      id: `appointment_status_${event.params.appointmentId}_${after.status as string}`,
      recipientId: after.customerId as string,
      kind: "appointment_status_changed",
      title: "Appointment updated",
      body: `Your appointment at ${after.businessName as string} is now ${after.status as string}.`,
      data: {
        type: "appointment",
        appointmentId: event.params.appointmentId,
        businessId: after.businessId as string,
      },
    });
  },
);
