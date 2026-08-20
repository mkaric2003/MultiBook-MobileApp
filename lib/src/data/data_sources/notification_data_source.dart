import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NotificationDataSource {
  Stream<RemoteMessage> get onMessageOpenedApp;
  Stream<String> get onTokenRefresh;

  Future<RemoteMessage?> getInitialMessage();
  Future<String> getDeviceId();
  Future<String?> requestDeviceToken();
}

@LazySingleton(as: NotificationDataSource)
class NotificationDataSourceImpl implements NotificationDataSource {
  static const _deviceIdKey = 'notification_device_id';

  NotificationDataSourceImpl(this._messaging);

  final FirebaseMessaging _messaging;

  @override
  Stream<RemoteMessage> get onMessageOpenedApp =>
      FirebaseMessaging.onMessageOpenedApp;

  @override
  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;

  @override
  Future<RemoteMessage?> getInitialMessage() => _messaging.getInitialMessage();

  @override
  Future<String> getDeviceId() async {
    final preferences = await SharedPreferences.getInstance();
    final existingId = preferences.getString(_deviceIdKey);
    if (existingId != null && existingId.isNotEmpty) return existingId;

    final deviceId =
        '${DateTime.now().microsecondsSinceEpoch}_${Random().nextInt(1 << 32)}';
    await preferences.setString(_deviceIdKey, deviceId);
    return deviceId;
  }

  @override
  Future<String?> requestDeviceToken() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.denied ||
        settings.authorizationStatus == AuthorizationStatus.notDetermined) {
      return null;
    }
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      final apnsToken = await _messaging.getAPNSToken();
      if (apnsToken == null) return null;
    }
    return _messaging.getToken();
  }
}
