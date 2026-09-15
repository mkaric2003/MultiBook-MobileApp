import { onDocumentCreated } from "firebase-functions/v2/firestore";
import { Timestamp } from "firebase-admin/firestore";

import { deliverChatPushNotification } from "./notification_dispatcher.js";

export const notifyOnChatMessageCreated = onDocumentCreated(
  "conversations/{conversationId}/messages/{messageId}",
  async (event) => {
    const message = event.data?.data();
    if (message == null) return;

    const conversation = await event.data?.ref.parent.parent?.get();
    const conversationData = conversation?.data();
    if (conversationData == null) return;

    const senderId = message.senderId as string;
    const customerId = conversationData.customerId as string;
    const businessOwnerId = conversationData.businessOwnerId as string;
    const recipientId = senderId === customerId ? businessOwnerId : customerId;
    const activeViewerExpiry = (
      conversationData.activeParticipantExpiresAt as Record<string, Timestamp> | undefined
    )?.[recipientId];
    if (activeViewerExpiry != null && activeViewerExpiry.toMillis() > Date.now()) {
      return;
    }
    const senderName = senderId === customerId
      ? (conversationData.customerName as string)
      : (conversationData.businessName as string);

    await deliverChatPushNotification({
      id: `chat_${event.params.messageId}`,
      recipientId,
      kind: "chat_message",
      title: senderName,
      body: (message.text as string).slice(0, 120),
      data: {
        type: "chat_message",
        conversationId: event.params.conversationId,
        businessId: conversationData.businessId as string,
        businessOwnerId,
        businessName: conversationData.businessName as string,
        businessImageUrl: conversationData.businessImageUrl as string,
        customerId,
        customerName: conversationData.customerName as string,
        customerImageUrl: (conversationData.customerImageUrl as string) ?? "",
      },
    });
  },
);
