import 'dart:async';
import 'dart:developer';

import 'package:aquabook/src/data/repositories/notification_repository.dart';
import 'package:aquabook/src/features/shared/notifications/cubit/notifications_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._repository) : super(const NotificationsState());

  final NotificationRepository _repository;
  StreamSubscription? _subscription;

  Future<void> load() async {
    await _subscription?.cancel();
    _subscription = _repository.watchInAppNotifications().listen(
      (notifications) => emit(
        NotificationsState(isLoading: false, notifications: notifications),
      ),
      onError: (Object error, StackTrace stackTrace) {
        log(
          'Could not load in-app notifications.',
          name: 'NotificationsCubit',
          error: error,
          stackTrace: stackTrace,
        );
        emit(
          const NotificationsState(
            isLoading: false,
            errorMessage: 'We could not load your notifications.',
          ),
        );
      },
    );
  }

  Future<void> markAsRead(String notificationId) =>
      _repository.markInAppNotificationAsRead(notificationId);

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
