import 'package:injectable/injectable.dart';
import 'package:multibook/src/data/data_sources/api_client.dart';
import 'package:multibook/src/data/models/app_notification_list_response.dart';

@lazySingleton
class InAppNotificationsApiDataSource {
  InAppNotificationsApiDataSource(this._client);

  final ApiClient _client;

  Future<AppNotificationListResponse> getNotifications({
    String? cursor,
    int pageSize = 20,
  }) async {
    final response = await _client.get(
      '/v1/notifications',
      queryParameters: {
        if (cursor != null) 'cursor': cursor,
        'page_size': pageSize,
      },
    );
    return AppNotificationListResponseMapper.fromMap(response.data!);
  }

  Future<int> getUnreadCount() async {
    final response = await _client.get('/v1/notifications/unread-count');
    return (response.data!['count'] as num?)?.toInt() ?? 0;
  }

  Future<void> markAsRead(String notificationId) =>
      _client.patch('/v1/notifications/$notificationId/read', data: const {});

  Future<void> registerDevice({
    required String deviceId,
    required String token,
  }) =>
      _client.put('/v1/notification-devices/$deviceId', data: {'token': token});

  Future<void> unregisterDevice(String deviceId) =>
      _client.delete('/v1/notification-devices/$deviceId');
}
