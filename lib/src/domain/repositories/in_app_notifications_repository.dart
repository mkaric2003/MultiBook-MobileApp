import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/app_notification_list_response.dart';

abstract class InAppNotificationsRepository {
  Future<Result<AppNotificationListResponse>> getNotifications({
    String? cursor,
    int pageSize = 20,
  });

  Future<Result<int>> getUnreadCount();
  Future<Result<void>> markAsRead(String notificationId);
  Future<Result<void>> registerDevice({
    required String deviceId,
    required String token,
  });
  Future<Result<void>> unregisterDevice(String deviceId);
}
