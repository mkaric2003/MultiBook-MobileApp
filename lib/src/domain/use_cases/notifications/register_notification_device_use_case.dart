import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/in_app_notifications_repository.dart';

@injectable
class RegisterNotificationDeviceUseCase {
  RegisterNotificationDeviceUseCase(this._repository);

  final InAppNotificationsRepository _repository;

  Future<Result<void>> execute({
    required String deviceId,
    required String token,
  }) => _repository.registerDevice(deviceId: deviceId, token: token);
}
