import { getFirestore, Timestamp } from "firebase-admin/firestore";
import { HttpsError, onCall } from "firebase-functions/v2/https";

type ReviewType = "stay" | "service";

interface CreateReviewRequest {
  businessId?: unknown;
  sourceId?: unknown;
  type?: unknown;
  rating?: unknown;
  comment?: unknown;
}

export const createReview = onCall<CreateReviewRequest>(
  { region: "us-central1" },
  async (request) => {
    const customerId = request.auth?.uid;
    if (customerId == null) {
      throw new HttpsError("unauthenticated", "You need to sign in to leave a review.");
    }

    const businessId = requiredString(request.data.businessId, "businessId");
    const sourceId = requiredString(request.data.sourceId, "sourceId");
    const type = reviewType(request.data.type);
    const rating = validRating(request.data.rating);
    const comment = optionalComment(request.data.comment);
    const database = getFirestore();
    const sourceCollection = type === "stay" ? "bookings" : "appointments";
    const sourceReference = database.collection(sourceCollection).doc(sourceId);
    const businessReference = database.collection("businesses").doc(businessId);
    const reviewReference = database
      .collection("reviews")
      .doc(`${businessId}_${customerId}`);

    await database.runTransaction(async (transaction) => {
      const [sourceSnapshot, businessSnapshot, reviewSnapshot] = await Promise.all([
        transaction.get(sourceReference),
        transaction.get(businessReference),
        transaction.get(reviewReference),
      ]);

      if (!sourceSnapshot.exists || !businessSnapshot.exists) {
        throw new HttpsError("not-found", "The reservation or business no longer exists.");
      }
      if (reviewSnapshot.exists) {
        throw new HttpsError("already-exists", "You have already reviewed this business.");
      }

      const source = sourceSnapshot.data()!;
      if (source.customerId !== customerId || source.businessId !== businessId) {
        throw new HttpsError("permission-denied", "You cannot review this reservation.");
      }
      if (!isFinished(source, type)) {
        throw new HttpsError(
          "failed-precondition",
          "You can leave a review after the reservation is completed.",
        );
      }

      const business = businessSnapshot.data()!;
      const previousCount = numberOrZero(business.reviewCount);
      const previousAverage = numberOrZero(business.averageRating);
      const reviewCount = previousCount + 1;
      const averageRating = (previousAverage * previousCount + rating) / reviewCount;

      transaction.set(reviewReference, {
        id: reviewReference.id,
        businessId,
        businessOwnerId: source.businessOwnerId,
        customerId,
        customerName: source.customerName ?? "",
        customerAvatarUrl: source.customerAvatarUrl ?? null,
        sourceId,
        sourceType: type,
        rating,
        comment,
        createdAt: Timestamp.now(),
      });
      transaction.update(businessReference, { averageRating, reviewCount });
    });

    return { success: true };
  },
);

function requiredString(value: unknown, name: string) {
  if (typeof value !== "string" || value.trim().length === 0) {
    throw new HttpsError("invalid-argument", `${name} is required.`);
  }
  return value.trim();
}

function reviewType(value: unknown): ReviewType {
  if (value === "stay" || value === "service") return value;
  throw new HttpsError("invalid-argument", "Invalid review type.");
}

function validRating(value: unknown) {
  if (typeof value !== "number" || !Number.isInteger(value) || value < 1 || value > 5) {
    throw new HttpsError("invalid-argument", "Rating must be between 1 and 5.");
  }
  return value;
}

function optionalComment(value: unknown) {
  if (value == null) return null;
  if (typeof value !== "string") {
    throw new HttpsError("invalid-argument", "Review comment must be text.");
  }
  return value.trim().slice(0, 1000) || null;
}

function isFinished(source: Record<string, unknown>, type: ReviewType) {
  if (source.status === "completed") return true;
  const now = new Date();
  if (type === "stay") {
    const checkOut = toDate(source.checkOut);
    return checkOut != null && checkOut < startOfToday(now);
  }
  const date = toDate(source.date);
  const endMinutes = numberOrZero(source.endMinutes);
  return date != null && new Date(date.getFullYear(), date.getMonth(), date.getDate(), 0, endMinutes) <= now;
}

function toDate(value: unknown) {
  if (value instanceof Timestamp) return value.toDate();
  if (value instanceof Date) return value;
  if (typeof value === "string" || typeof value === "number") {
    const parsed = new Date(value);
    return Number.isNaN(parsed.getTime()) ? null : parsed;
  }
  if (
    typeof value === "object" &&
    value != null &&
    "toDate" in value &&
    typeof value.toDate === "function"
  ) {
    const date = value.toDate();
    return date instanceof Date ? date : null;
  }
  return null;
}

function startOfToday(date: Date) {
  return new Date(date.getFullYear(), date.getMonth(), date.getDate());
}

function numberOrZero(value: unknown) {
  return typeof value === "number" && Number.isFinite(value) ? value : 0;
}
