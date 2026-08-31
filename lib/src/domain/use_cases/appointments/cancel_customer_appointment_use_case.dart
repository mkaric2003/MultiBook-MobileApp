import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/domain/repositories/customer_appointments_repository.dart';

@injectable
class CancelCustomerAppointmentUseCase {
  CancelCustomerAppointmentUseCase(this._repository);

  final CustomerAppointmentsRepository _repository;

  Future<Result<AppointmentModel>> execute(String appointmentId) =>
      _repository.cancelAppointment(appointmentId);
}
