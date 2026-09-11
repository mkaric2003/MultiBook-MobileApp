import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/domain/repositories/provider_bookings_repository.dart';

@injectable
class UpdateProviderAppointmentStatusUseCase {
  UpdateProviderAppointmentStatusUseCase(this._repository);
  final ProviderBookingsRepository _repository;
  Future<Result<AppointmentModel>> execute({
    required String appointmentId,
    required String status,
  }) => _repository.updateAppointmentStatus(
    appointmentId: appointmentId,
    status: status,
  );
}
