import { getApps, initializeApp } from "firebase-admin/app";
import { FieldValue, Timestamp, getFirestore } from "firebase-admin/firestore";
import { getMessaging } from "firebase-admin/messaging";

import { NotificationPayload } from "./notification_payload.js";

if (getApps().length === 0) initializeApp();

const db = getFirestore();
const claimTimeoutMs = 5 * 60 * 1000;

export async function createAndDeliverNotification(
  payload: NotificationPayload,
): Promise<void> {
  const notificationReference = db.doc(
    `users/${payload.recipientId}/notifications/${payload.id}`,
  );
  const userReference = db.doc(`users/${payload.recipientId}`);
  const claimed = await db.runTransaction(async (transaction) => {
    const snapshot = await transaction.get(notificationReference);
    const current = snapshot.data();
    const status = current?.deliveryStatus as string | undefined;
    const processingStartedAt = current?.processingStartedAt as
      | Timestamp
      | undefined;
    const isFreshClaim =
      status === "processing" &&
      processingStartedAt != null &&
      Date.now() - processingStartedAt.toMillis() < claimTimeoutMs;

    if (status === "sent" || isFreshClaim) return false;

    if (!snapshot.exists) {
      transaction.set(
        userReference,
        {
          unreadNotificationsCount: FieldValue.increment(1),
        },
        { merge: true },
      );
    }

    transaction.set(
      notificationReference,
      {
        id: payload.id,
        recipientId: payload.recipientId,
        kind: payload.kind,
        title: payload.title,
        body: payload.body,
        data: payload.data,
        createdAt: current?.createdAt ?? FieldValue.serverTimestamp(),
        readAt: null,
        deliveryStatus: "processing",
        processingStartedAt: FieldValue.serverTimestamp(),
        deliveryAttempts: FieldValue.increment(1),
      },
      { merge: true },
    );
    return true;
  });

  if (!claimed) return;

  try {
    const devices = await db
      .collection(`users/${payload.recipientId}/devices`)
      .where("enabled", "==", true)
      .get();
    const tokens = devices.docs
      .map((device) => ({ id: device.id, token: device.data().token as string }))
      .filter((device) => device.token.length > 0);

    if (tokens.length === 0) {
      await notificationReference.update({
        deliveryStatus: "skipped",
        sentAt: FieldValue.serverTimestamp(),
        deliveryCount: 0,
      });
      return;
    }

    const response = await getMessaging().sendEachForMulticast({
      tokens: tokens.map((device) => device.token),
      notification: { title: payload.title, body: payload.body },
      data: { ...payload.data, notificationId: payload.id },
      android: { priority: "high" },
      apns: {
        payload: {
          aps: { sound: "default", contentAvailable: true },
        },
      },
    });

    const invalidDeviceIds = response.responses
      .map((result, index) => ({ result, deviceId: tokens[index].id }))
      .filter(({ result }) => {
        const code = result.error?.code;
        return (
          code === "messaging/invalid-registration-token" ||
          code === "messaging/registration-token-not-registered"
        );
      })
      .map(({ deviceId }) => deviceId);
    if (invalidDeviceIds.length > 0) {
      const batch = db.batch();
      for (const deviceId of invalidDeviceIds) {
        batch.delete(db.doc(`users/${payload.recipientId}/devices/${deviceId}`));
      }
      await batch.commit();
    }

    await notificationReference.update({
      deliveryStatus: "sent",
      sentAt: FieldValue.serverTimestamp(),
      deliveryCount: response.successCount,
      failureCount: response.failureCount,
    });
  } catch (error) {
    await notificationReference.update({
      deliveryStatus: "failed",
      failedAt: FieldValue.serverTimestamp(),
    });
    console.error(`Notification ${payload.id} failed.`, error);
    throw error;
  }
}

export async function deliverChatPushNotification(
  payload: NotificationPayload,
): Promise<void> {
  const deliveryReference = db.doc(`notification_deliveries/${payload.id}`);
  const userReference = db.doc(`users/${payload.recipientId}`);
  const claimed = await db.runTransaction(async (transaction) => {
    const snapshot = await transaction.get(deliveryReference);
    const current = snapshot.data();
    const status = current?.deliveryStatus as string | undefined;
    const processingStartedAt = current?.processingStartedAt as
      | Timestamp
      | undefined;
    const isFreshClaim =
      status === "processing" &&
      processingStartedAt != null &&
      Date.now() - processingStartedAt.toMillis() < claimTimeoutMs;

    if (status === "sent" || isFreshClaim) return false;
    if (!snapshot.exists) {
      transaction.set(
        userReference,
        { unreadMessagesCount: FieldValue.increment(1) },
        { merge: true },
      );
    }
    transaction.set(
      deliveryReference,
      {
        id: payload.id,
        recipientId: payload.recipientId,
        kind: payload.kind,
        createdAt: current?.createdAt ?? FieldValue.serverTimestamp(),
        deliveryStatus: "processing",
        processingStartedAt: FieldValue.serverTimestamp(),
        deliveryAttempts: FieldValue.increment(1),
      },
      { merge: true },
    );
    return true;
  });

  if (!claimed) return;

  try {
    const devices = await db
      .collection(`users/${payload.recipientId}/devices`)
      .where("enabled", "==", true)
      .get();
    const tokens = devices.docs
      .map((device) => ({ id: device.id, token: device.data().token as string }))
      .filter((device) => device.token.length > 0);

    if (tokens.length === 0) {
      await deliveryReference.update({
        deliveryStatus: "skipped",
        sentAt: FieldValue.serverTimestamp(),
        deliveryCount: 0,
      });
      return;
    }

    const response = await getMessaging().sendEachForMulticast({
      tokens: tokens.map((device) => device.token),
      notification: { title: payload.title, body: payload.body },
      data: { ...payload.data, notificationId: payload.id },
      android: { priority: "high" },
      apns: { payload: { aps: { sound: "default", contentAvailable: true } } },
    });
    const invalidDeviceIds = response.responses
      .map((result, index) => ({ result, deviceId: tokens[index].id }))
      .filter(({ result }) => {
        const code = result.error?.code;
        return (
          code === "messaging/invalid-registration-token" ||
          code === "messaging/registration-token-not-registered"
        );
      })
      .map(({ deviceId }) => deviceId);
    if (invalidDeviceIds.length > 0) {
      const batch = db.batch();
      for (const deviceId of invalidDeviceIds) {
        batch.delete(db.doc(`users/${payload.recipientId}/devices/${deviceId}`));
      }
      await batch.commit();
    }
    await deliveryReference.update({
      deliveryStatus: "sent",
      sentAt: FieldValue.serverTimestamp(),
      deliveryCount: response.successCount,
      failureCount: response.failureCount,
    });
  } catch (error) {
    await deliveryReference.update({
      deliveryStatus: "failed",
      failedAt: FieldValue.serverTimestamp(),
    });
    console.error(`Chat push ${payload.id} failed.`, error);
    throw error;
  }
}
