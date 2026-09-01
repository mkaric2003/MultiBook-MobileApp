import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/core/services/notification_device_service.dart';
import 'package:multibook/src/domain/use_cases/notifications/get_unread_notifications_count_use_case.dart';

@injectable
class NotificationBellCubit extends Cubit<int> {
  NotificationBellCubit(this._getUnreadCount, this._notificationDeviceService)
    : super(0);

  final GetUnreadNotificationsCountUseCase _getUnreadCount;
  final NotificationDeviceService _notificationDeviceService;
  Timer? _refreshTimer;
  StreamSubscription<void>? _foregroundMessageSubscription;

  void start() {
    if (_refreshTimer != null) return;
    unawaited(load());
    _foregroundMessageSubscription = _notificationDeviceService
        .onForegroundMessage
        .listen((_) => unawaited(load()));
    _refreshTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => unawaited(load()),
    );
  }

  Future<void> load() async {
    final result = await _getUnreadCount.execute();
    if (isClosed || result is! Success<int>) return;
    emit(result.value);
  }

  @override
  Future<void> close() {
    _refreshTimer?.cancel();
    _foregroundMessageSubscription?.cancel();
    return super.close();
  }
}
