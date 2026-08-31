import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/appointment_list_response.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/models/reschedule_appointment_request.dart';

abstract class CustomerAppointmentsRepository {
  Future<Result<AppointmentListResponse>> getAppointments({
    String? cursor,
    int pageSize = 20,
  });

  Future<Result<AppointmentModel>> cancelAppointment(String appointmentId);

  Future<Result<AppointmentModel>> rescheduleAppointment({
    required String appointmentId,
    required RescheduleAppointmentRequest request,
  });
}
