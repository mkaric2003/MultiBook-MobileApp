import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multibook/app.dart';
import 'package:multibook/src/core/config/app_environment.dart';
import 'package:multibook/src/core/config/app_flavor.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/core/services/notification_device_service.dart';
import 'package:multibook/src/features/shared/notifications/application/notification_coordinator.dart';
import 'package:multibook/src/features/shared/notifications/presentation/navigation/notification_router.dart';

late final NotificationCoordinator _notificationCoordinator;

Future<void> bootstrap(AppFlavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  AppEnvironment.initialize(flavor);

  await configureDependencies();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  _notificationCoordinator = NotificationCoordinator(
    getIt<NotificationDeviceService>(),
    NotificationRouter(router),
  );
  runApp(const App());
  WidgetsBinding.instance.addPostFrameCallback(
    (_) => unawaited(_notificationCoordinator.initialize()),
  );
}
