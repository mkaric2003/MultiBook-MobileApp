import 'package:injectable/injectable.dart';
import 'package:multibook/src/data/data_sources/api_client.dart';
import 'package:multibook/src/data/models/appointment_list_response.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/models/booking_list_response.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/data/models/update_appointment_status_request.dart';

@lazySingleton
class ProviderBookingsApiDataSource {
  ProviderBookingsApiDataSource(this._client);

  final ApiClient _client;

  Future<BookingListResponse> getBookings({
    required String businessId,
    String? status,
    String? cursor,
    int pageSize = 20,
  }) async {
    final response = await _client.get(
      '/v1/bookings',
      queryParameters: {
        'business_id': businessId,
        if (status != null) 'status': status,
        if (cursor != null) 'cursor': cursor,
        'page_size': pageSize,
      },
    );
    return BookingListResponseMapper.fromMap(response.data!);
  }

  Future<BookingModel> updateBookingStatus({
    required String bookingId,
    required String status,
  }) async {
    final response = await _client.patch(
      '/v1/bookings/$bookingId/status',
      data: {'status': status},
    );
    return BookingModel.fromMap(response.data!);
  }

  Future<AppointmentListResponse> getAppointments({
    required String businessId,
    String? status,
    String? cursor,
    int pageSize = 20,
  }) async {
    final response = await _client.get(
      '/v1/appointments',
      queryParameters: {
        'business_id': businessId,
        if (status != null) 'status': status,
        if (cursor != null) 'cursor': cursor,
        'page_size': pageSize,
      },
    );
    return AppointmentListResponseMapper.fromMap(response.data!);
  }

  Future<AppointmentModel> updateAppointmentStatus({
    required String appointmentId,
    required String status,
  }) async {
    final response = await _client.patch(
      '/v1/appointments/$appointmentId/status',
      data: UpdateAppointmentStatusRequest(status: status).toMap(),
    );
    return AppointmentModel.fromMap(response.data!);
  }
}
