import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/available_appointment_slots_model.dart';
import 'package:multibook/src/domain/repositories/customer_appointments_repository.dart';

@injectable
class GetAvailableAppointmentSlotsUseCase {
  GetAvailableAppointmentSlotsUseCase(this._repository);

  final CustomerAppointmentsRepository _repository;

  Future<Result<AvailableAppointmentSlotsModel>> execute({
    required String businessId,
    required String staffId,
    required DateTime appointmentDate,
    required List<String> offeringIds,
    String? excludeAppointmentId,
  }) => _repository.getAvailableSlots(
    businessId: businessId,
    staffId: staffId,
    appointmentDate: appointmentDate,
    offeringIds: offeringIds,
    excludeAppointmentId: excludeAppointmentId,
  );
}
