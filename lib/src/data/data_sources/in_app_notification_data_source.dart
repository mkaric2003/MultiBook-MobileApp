import 'package:multibook/src/data/models/app_notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

abstract class InAppNotificationDataSource {
  Stream<List<AppNotificationModel>> watchNotifications(String userId);
  Stream<int> watchUnreadCount(String userId);
  Future<void> ensureUnreadCount(String userId);

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
                .where((notification) => notification.kind != 'chat_message')
                .toList(),
          );

  @override
  Stream<int> watchUnreadCount(String userId) => _firestore
      .collection('users')
      .doc(userId)
      .snapshots()
      .map(
        (snapshot) =>
            (snapshot.data()?['unreadNotificationsCount'] as num?)?.toInt() ??
            0,
      );

  @override
  Future<void> ensureUnreadCount(String userId) async {
    final userReference = _firestore.collection('users').doc(userId);
    await _excludeLegacyChatNotifications(userReference);
    final unreadNotifications = await userReference
        .collection('notifications')
        .where('readAt', isNull: true)
        .get();
    await _firestore.runTransaction((transaction) async {
      final user = await transaction.get(userReference);
      if (user.data()?.containsKey('unreadNotificationsCount') ?? false) {
        return;
      }
      transaction.set(userReference, {
        'unreadNotificationsCount': unreadNotifications.docs.length,
      }, SetOptions(merge: true));
    });
  }

  Future<void> _excludeLegacyChatNotifications(
    DocumentReference<Map<String, dynamic>> userReference,
  ) async {
    final user = await userReference.get();
    if (user.data()?['hasExcludedChatNotifications'] == true) return;
    final chatNotifications = await userReference
        .collection('notifications')
        .where('kind', isEqualTo: 'chat_message')
        .get();
    final unreadChatNotifications = chatNotifications.docs
        .where((document) => document.data()['readAt'] == null)
        .toList();
    await _firestore.runTransaction((transaction) async {
      final latestUser = await transaction.get(userReference);
      if (latestUser.data()?['hasExcludedChatNotifications'] == true) return;
      for (final notification in unreadChatNotifications) {
        transaction.update(notification.reference, {
          'readAt': FieldValue.serverTimestamp(),
        });
      }
      final currentUnreadCount =
          (latestUser.data()?['unreadNotificationsCount'] as num?)?.toInt() ??
          0;
      transaction.set(userReference, {
        'unreadNotificationsCount':
            (currentUnreadCount - unreadChatNotifications.length).clamp(
              0,
              1 << 31,
            ),
        'hasExcludedChatNotifications': true,
      }, SetOptions(merge: true));
    });
  }

  @override
  Future<void> markAsRead({
    required String userId,
    required String notificationId,
  }) async {
    final userReference = _firestore.collection('users').doc(userId);
    final notificationReference = userReference
        .collection('notifications')
        .doc(notificationId);
    await _firestore.runTransaction((transaction) async {
      final notification = await transaction.get(notificationReference);
      if (!notification.exists || notification.data()?['readAt'] != null) {
        return;
      }
      final user = await transaction.get(userReference);
      final unreadCount =
          (user.data()?['unreadNotificationsCount'] as num?)?.toInt() ?? 0;
      transaction.update(notificationReference, {
        'readAt': FieldValue.serverTimestamp(),
      });
      transaction.set(userReference, {
        'unreadNotificationsCount': unreadCount > 0 ? unreadCount - 1 : 0,
      }, SetOptions(merge: true));
    });
  }
}
