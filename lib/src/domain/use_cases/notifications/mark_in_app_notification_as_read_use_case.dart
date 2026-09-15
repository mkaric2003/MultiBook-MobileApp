import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/in_app_notifications_repository.dart';

@injectable
class MarkInAppNotificationAsReadUseCase {
  MarkInAppNotificationAsReadUseCase(this._repository);

  final InAppNotificationsRepository _repository;

  Future<Result<void>> execute(String notificationId) =>
      _repository.markAsRead(notificationId);
}
