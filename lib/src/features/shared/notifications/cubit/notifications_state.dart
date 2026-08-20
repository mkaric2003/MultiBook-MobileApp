import 'package:aquabook/src/data/models/app_notification_model.dart';

class NotificationsState {
  const NotificationsState({
    this.isLoading = true,
    this.notifications = const [],
    this.errorMessage,
  });

  final bool isLoading;
  final List<AppNotificationModel> notifications;
  final String? errorMessage;

  int get unreadCount => notifications.where((item) => !item.isRead).length;
}
