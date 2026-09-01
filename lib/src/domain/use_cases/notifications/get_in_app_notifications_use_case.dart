import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/app_notification_list_response.dart';
import 'package:multibook/src/domain/repositories/in_app_notifications_repository.dart';

@injectable
class GetInAppNotificationsUseCase {
  GetInAppNotificationsUseCase(this._repository);

  final InAppNotificationsRepository _repository;

  Future<Result<AppNotificationListResponse>> execute({
    String? cursor,
    int pageSize = 20,
  }) => _repository.getNotifications(cursor: cursor, pageSize: pageSize);
}
