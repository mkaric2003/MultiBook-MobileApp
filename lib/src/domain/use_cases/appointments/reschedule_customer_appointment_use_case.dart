import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/models/reschedule_appointment_request.dart';
import 'package:multibook/src/domain/repositories/customer_appointments_repository.dart';

@injectable
class RescheduleCustomerAppointmentUseCase {
  RescheduleCustomerAppointmentUseCase(this._repository);

  final CustomerAppointmentsRepository _repository;

  Future<Result<AppointmentModel>> execute({
    required String appointmentId,
    required RescheduleAppointmentRequest request,
  }) => _repository.rescheduleAppointment(
    appointmentId: appointmentId,
    request: request,
  );
}
