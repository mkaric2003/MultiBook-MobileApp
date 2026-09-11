import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/networking/api_client.dart';
import 'package:multibook/src/data/models/appointment_list_response.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/models/available_appointment_slots_model.dart';
import 'package:multibook/src/data/models/reschedule_appointment_request.dart';
import 'package:multibook/src/data/models/update_appointment_status_request.dart';

@lazySingleton
class CustomerAppointmentsApiDataSource {
  CustomerAppointmentsApiDataSource(this._client);

  final ApiClient _client;

  Future<AvailableAppointmentSlotsModel> getAvailableSlots({
    required String businessId,
    required String staffId,
    required DateTime appointmentDate,
    required List<String> offeringIds,
    String? excludeAppointmentId,
  }) async {
    final response = await _client.get(
      '/v1/businesses/$businessId/service/staff/$staffId/available-slots',
      queryParameters: {
        'appointment_date': _dateKey(appointmentDate),
        'offering_id': offeringIds,
        if (excludeAppointmentId != null)
          'exclude_appointment_id': excludeAppointmentId,
      },
    );
    return AvailableAppointmentSlotsModelMapper.fromMap(response.data!);
  }

  Future<AppointmentListResponse> getAppointments({
    String? cursor,
    int pageSize = 20,
  }) async {
    final response = await _client.get(
      '/v1/appointments',
      queryParameters: {
        if (cursor != null) 'cursor': cursor,
        'page_size': pageSize,
      },
    );
    return AppointmentListResponseMapper.fromMap(response.data!);
  }

  Future<AppointmentModel> cancelAppointment(String appointmentId) async {
    final response = await _client.patch(
      '/v1/appointments/$appointmentId/status',
      data: UpdateAppointmentStatusRequest(status: 'cancelled').toMap(),
    );
    return AppointmentModel.fromMap(response.data!);
  }

  Future<AppointmentModel> rescheduleAppointment({
    required String appointmentId,
    required RescheduleAppointmentRequest request,
  }) async {
    final response = await _client.patch(
      '/v1/appointments/$appointmentId/reschedule',
      data: request.toMap(),
    );
    return AppointmentModel.fromMap(response.data!);
  }

  String _dateKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}
