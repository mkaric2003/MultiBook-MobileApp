import 'package:aquabook/src/data/models/app_notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

abstract class InAppNotificationDataSource {
  Stream<List<AppNotificationModel>> watchNotifications(String userId);

  Future<void> markAsRead({
    required String userId,
    required String notificationId,
  });
}

@LazySingleton(as: InAppNotificationDataSource)
class InAppNotificationDataSourceImpl implements InAppNotificationDataSource {
  InAppNotificationDataSourceImpl(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Stream<List<AppNotificationModel>> watchNotifications(String userId) =>
      _firestore
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map(
                  (document) => AppNotificationModel.fromJson(document.data()),
                )
                .toList(),
          );

  @override
  Future<void> markAsRead({
    required String userId,
    required String notificationId,
  }) => _firestore
      .collection('users')
      .doc(userId)
      .collection('notifications')
      .doc(notificationId)
      .update({'readAt': FieldValue.serverTimestamp()});
}
