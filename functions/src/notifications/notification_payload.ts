export type NotificationKind =
  | "chat_message"
  | "booking_created"
  | "booking_status_changed"
  | "appointment_created"
  | "appointment_status_changed";

export interface NotificationPayload {
  readonly id: string;
  readonly recipientId: string;
  readonly kind: NotificationKind;
  readonly title: string;
  readonly body: string;
  readonly data: Record<string, string>;
}
