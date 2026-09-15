import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/rest_repository_executor.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/data_sources/in_app_notifications_api_data_source.dart';
import 'package:multibook/src/data/models/app_notification_list_response.dart';
import 'package:multibook/src/domain/repositories/in_app_notifications_repository.dart';

@LazySingleton(as: InAppNotificationsRepository)
class InAppNotificationsRepositoryImpl implements InAppNotificationsRepository {
  InAppNotificationsRepositoryImpl(this._source, this._executor);

  final InAppNotificationsApiDataSource _source;
  final RestRepositoryExecutor _executor;

  @override
  Future<Result<AppNotificationListResponse>> getNotifications({
    String? cursor,
    int pageSize = 20,
  }) => _executor.execute(
    () => _source.getNotifications(cursor: cursor, pageSize: pageSize),
  );

  @override
  Future<Result<int>> getUnreadCount() =>
      _executor.execute(_source.getUnreadCount);

  @override
  Future<Result<void>> markAsRead(String notificationId) =>
      _executor.execute(() => _source.markAsRead(notificationId));

  @override
  Future<Result<void>> registerDevice({
    required String deviceId,
    required String token,
  }) => _executor.execute(
    () => _source.registerDevice(deviceId: deviceId, token: token),
  );

  @override
  Future<Result<void>> unregisterDevice(String deviceId) =>
      _executor.execute(() => _source.unregisterDevice(deviceId));
}
