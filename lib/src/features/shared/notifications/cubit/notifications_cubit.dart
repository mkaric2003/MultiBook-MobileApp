import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/use_cases/notifications/get_in_app_notifications_use_case.dart';
import 'package:multibook/src/domain/use_cases/notifications/mark_in_app_notification_as_read_use_case.dart';
import 'package:multibook/src/features/shared/notifications/cubit/notifications_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._getNotifications, this._markAsRead)
    : super(const NotificationsState());

  final GetInAppNotificationsUseCase _getNotifications;
  final MarkInAppNotificationAsReadUseCase _markAsRead;

  Future<void> load() async {
    final result = await _getNotifications.execute(pageSize: 50);
    switch (result) {
      case Success(:final value):
        emit(NotificationsState(isLoading: false, notifications: value.items));
      case FailureResult():
        emit(
          const NotificationsState(
            isLoading: false,
            errorMessage: 'We could not load your notifications.',
          ),
        );
    }
  }

  Future<void> markAsRead(String notificationId) async {
    final result = await _markAsRead.execute(notificationId);
    if (result is! Success<void>) return;
    emit(
      NotificationsState(
        isLoading: false,
        notifications: state.notifications
            .map(
              (notification) => notification.id == notificationId
                  ? notification.copyWith(readAt: DateTime.now())
                  : notification,
            )
            .toList(),
      ),
    );
  }
}
