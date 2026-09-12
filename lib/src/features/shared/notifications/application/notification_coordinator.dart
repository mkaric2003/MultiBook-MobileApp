import 'dart:async';
import 'dart:developer';

import 'package:multibook/src/core/services/notification_device_service.dart';
import 'package:multibook/src/features/shared/notifications/domain/notification_navigation.dart';

class NotificationCoordinator {
  NotificationCoordinator(this._deviceService, this._navigation);

  final NotificationDeviceService _deviceService;
  final NotificationNavigation _navigation;
  StreamSubscription<Map<String, String>>? _openedNotificationSubscription;

  Future<void> initialize() async {
    if (_openedNotificationSubscription != null) return;

    _openedNotificationSubscription = _deviceService.onNotificationOpened
        .listen(
          _navigation.open,
          onError: (Object error, StackTrace stackTrace) => log(
            'Could not handle an opened notification.',
            name: 'NotificationCoordinator',
            error: error,
            stackTrace: stackTrace,
          ),
        );
    try {
      await _deviceService.initialize();
    } catch (error, stackTrace) {
      log(
        'Could not initialize notification handling.',
        name: 'NotificationCoordinator',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> dispose() async {
    await _openedNotificationSubscription?.cancel();
    _openedNotificationSubscription = null;
  }
}
