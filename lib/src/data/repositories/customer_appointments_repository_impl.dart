import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/rest_repository_executor.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/data_sources/customer_appointments_api_data_source.dart';
import 'package:multibook/src/data/models/appointment_list_response.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/models/available_appointment_slots_model.dart';
import 'package:multibook/src/data/models/reschedule_appointment_request.dart';
import 'package:multibook/src/domain/repositories/customer_appointments_repository.dart';

@LazySingleton(as: CustomerAppointmentsRepository)
class CustomerAppointmentsRepositoryImpl
    implements CustomerAppointmentsRepository {
  CustomerAppointmentsRepositoryImpl(this._source, this._executor);

  final CustomerAppointmentsApiDataSource _source;
  final RestRepositoryExecutor _executor;

  @override
  Future<Result<AvailableAppointmentSlotsModel>> getAvailableSlots({
    required String businessId,
    required String staffId,
    required DateTime appointmentDate,
    required List<String> offeringIds,
    String? excludeAppointmentId,
  }) => _executor.execute(
    () => _source.getAvailableSlots(
      businessId: businessId,
      staffId: staffId,
      appointmentDate: appointmentDate,
      offeringIds: offeringIds,
      excludeAppointmentId: excludeAppointmentId,
    ),
  );

  @override
  Future<Result<AppointmentListResponse>> getAppointments({
    String? cursor,
    int pageSize = 20,
  }) => _executor.execute(
    () => _source.getAppointments(cursor: cursor, pageSize: pageSize),
  );

  @override
  Future<Result<AppointmentModel>> cancelAppointment(String appointmentId) =>
      _executor.execute(() => _source.cancelAppointment(appointmentId));

  @override
  Future<Result<AppointmentModel>> rescheduleAppointment({
    required String appointmentId,
    required RescheduleAppointmentRequest request,
  }) => _executor.execute(
    () => _source.rescheduleAppointment(
      appointmentId: appointmentId,
      request: request,
    ),
  );
}
