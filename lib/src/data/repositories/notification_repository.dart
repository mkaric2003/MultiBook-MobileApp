import 'dart:async';
import 'dart:developer';

import 'package:aquabook/src/data/data_sources/authentication_data_source.dart';
import 'package:aquabook/src/data/data_sources/firestore_data_source.dart';
import 'package:aquabook/src/data/data_sources/in_app_notification_data_source.dart';
import 'package:aquabook/src/data/data_sources/notification_data_source.dart';
import 'package:aquabook/src/data/models/app_notification_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NotificationRepository {
  NotificationRepository(
    this._authenticationDataSource,
    this._firestoreDataSource,
    this._notificationDataSource,
    this._inAppNotificationDataSource,
  );

  final AuthenticationDataSource _authenticationDataSource;
  final FirestoreDataSource _firestoreDataSource;
  final NotificationDataSource _notificationDataSource;
  final InAppNotificationDataSource _inAppNotificationDataSource;
  StreamSubscription<RemoteMessage>? _messageOpenedSubscription;
  StreamSubscription<String>? _tokenRefreshSubscription;
  ValueChanged<Map<String, String>>? _onNotificationOpened;
  bool _isInitialized = false;

  Future<void> initialize({
    required ValueChanged<Map<String, String>> onNotificationOpened,
  }) async {
    if (_isInitialized) return;
    _isInitialized = true;
    _onNotificationOpened = onNotificationOpened;
    _messageOpenedSubscription = _notificationDataSource.onMessageOpenedApp
        .listen(_handleOpenedMessage);
    _tokenRefreshSubscription = _notificationDataSource.onTokenRefresh.listen(
      _saveToken,
      onError: (Object error, StackTrace stackTrace) => log(
        'Could not refresh the notification token.',
        name: 'NotificationRepository',
        error: error,
        stackTrace: stackTrace,
      ),
    );

    final initialMessage = await _notificationDataSource.getInitialMessage();
    if (initialMessage != null) _handleOpenedMessage(initialMessage);
    try {
      await ensureUnreadInAppNotificationsCount();
    } catch (error, stackTrace) {
      log(
        'Could not initialize the unread notification count.',
        name: 'NotificationRepository',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> registerCurrentDevice() async {
    await ensureUnreadInAppNotificationsCount();
    final token = await _notificationDataSource.requestDeviceToken();
    if (token == null || token.isEmpty) return;
    await _saveToken(token);
  }

  Future<void> unregisterCurrentDevice() async {
    final userId = _authenticationDataSource.currentUser?.uid;
    if (userId == null) return;
    final deviceId = await _notificationDataSource.getDeviceId();
    await _firestoreDataSource.deleteDocument(
      collection: 'users/$userId/devices',
      documentId: deviceId,
    );
  }

  Stream<List<AppNotificationModel>> watchInAppNotifications() {
    final userId = _authenticationDataSource.currentUser?.uid;
    if (userId == null) return Stream.value(const []);
    return _inAppNotificationDataSource.watchNotifications(userId);
  }

  Stream<int> watchUnreadInAppNotificationsCount() =>
      _authenticationDataSource.currentUser == null
      ? Stream.value(0)
      : _inAppNotificationDataSource.watchUnreadCount(
          _authenticationDataSource.currentUser!.uid,
        );

  Future<void> ensureUnreadInAppNotificationsCount() async {
    final userId = _authenticationDataSource.currentUser?.uid;
    if (userId == null) return;
    await _inAppNotificationDataSource.ensureUnreadCount(userId);
  }

  Future<void> markInAppNotificationAsRead(String notificationId) async {
    final userId = _authenticationDataSource.currentUser?.uid;
    if (userId == null) return;
    await _inAppNotificationDataSource.markAsRead(
      userId: userId,
      notificationId: notificationId,
    );
  }

  Future<void> _saveToken(String token) async {
    final userId = _authenticationDataSource.currentUser?.uid;
    if (userId == null) return;
    final deviceId = await _notificationDataSource.getDeviceId();
    await _firestoreDataSource.setDocument(
      collection: 'users/$userId/devices',
      documentId: deviceId,
      merge: true,
      data: {
        'id': deviceId,
        'userId': userId,
        'token': token,
        'enabled': true,
        'updatedAt': _firestoreDataSource.serverTimestamp,
      },
    );
  }

  void _handleOpenedMessage(RemoteMessage message) {
    final data = Map<String, String>.from(message.data);
    if (data.isNotEmpty) _onNotificationOpened?.call(data);
  }

  @disposeMethod
  Future<void> dispose() async {
    await _messageOpenedSubscription?.cancel();
    await _tokenRefreshSubscription?.cancel();
  }
}
