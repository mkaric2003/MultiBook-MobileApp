import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:multibook/src/data/data_sources/authentication_data_source.dart';
import 'package:multibook/src/data/data_sources/notification_data_source.dart';
import 'package:multibook/src/domain/use_cases/notifications/register_notification_device_use_case.dart';
import 'package:multibook/src/domain/use_cases/notifications/unregister_notification_device_use_case.dart';

/// Coordinates the FCM device lifecycle with notification use cases.
///
/// It is an application service, not a data repository. Repositories are
/// implemented by the data layer; use cases own calls to repository contracts.
@lazySingleton
class NotificationDeviceService {
  NotificationDeviceService(
    this._authenticationDataSource,
    this._notificationDataSource,
    this._registerDevice,
    this._unregisterDevice,
  );

  final AuthenticationDataSource _authenticationDataSource;
  final NotificationDataSource _notificationDataSource;
  final RegisterNotificationDeviceUseCase _registerDevice;
  final UnregisterNotificationDeviceUseCase _unregisterDevice;
  final _foregroundMessages = StreamController<Map<String, String>>.broadcast();
  final _openedNotifications =
      StreamController<Map<String, String>>.broadcast();
  StreamSubscription<RemoteMessage>? _foregroundMessageSubscription;
  StreamSubscription<RemoteMessage>? _messageOpenedSubscription;
  StreamSubscription<String>? _tokenRefreshSubscription;
  bool _isInitialized = false;

  Stream<Map<String, String>> get onForegroundMessage =>
      _foregroundMessages.stream;

  Stream<Map<String, String>> get onNotificationOpened =>
      _openedNotifications.stream;

  Future<void> initialize() async {
    if (_isInitialized) return;
    _isInitialized = true;
    _foregroundMessageSubscription = _notificationDataSource.onMessage.listen(
      (message) =>
          _foregroundMessages.add(Map<String, String>.from(message.data)),
    );
    _messageOpenedSubscription = _notificationDataSource.onMessageOpenedApp
        .listen(_handleOpenedMessage);
    _tokenRefreshSubscription = _notificationDataSource.onTokenRefresh.listen(
      _saveToken,
      onError: (Object error, StackTrace stackTrace) => log(
        'Could not refresh the notification token.',
        name: 'NotificationDeviceService',
        error: error,
        stackTrace: stackTrace,
      ),
    );

    final initialMessage = await _notificationDataSource.getInitialMessage();
    if (initialMessage != null) _handleOpenedMessage(initialMessage);
  }

  Future<void> registerCurrentDevice() async {
    final token = await _notificationDataSource.requestDeviceToken();
    if (token == null || token.isEmpty) return;
    await _saveToken(token);
  }

  Future<void> unregisterCurrentDevice() async {
    if (_authenticationDataSource.currentUser == null) return;
    final deviceId = await _notificationDataSource.getDeviceId();
    await _unregisterDevice.execute(deviceId);
  }

  Future<void> _saveToken(String token) async {
    if (_authenticationDataSource.currentUser == null) return;
    final deviceId = await _notificationDataSource.getDeviceId();
    await _registerDevice.execute(deviceId: deviceId, token: token);
  }

  void _handleOpenedMessage(RemoteMessage message) {
    final data = Map<String, String>.from(message.data);
    if (data.isNotEmpty) _openedNotifications.add(data);
  }

  @disposeMethod
  Future<void> dispose() async {
    await _foregroundMessageSubscription?.cancel();
    await _messageOpenedSubscription?.cancel();
    await _tokenRefreshSubscription?.cancel();
    await _foregroundMessages.close();
    await _openedNotifications.close();
  }
}
