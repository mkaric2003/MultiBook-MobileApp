import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/networking/api_client.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/data/models/create_appointment_request.dart';
import 'package:multibook/src/data/models/create_booking_request.dart';

@lazySingleton
class CustomerCheckoutApiDataSource {
  CustomerCheckoutApiDataSource(this._client);
  final ApiClient _client;

  Future<BookingModel> createBooking({
    required String businessId,
    required CreateBookingRequest request,
  }) async {
    final data = (await _client.post(
      '/v1/businesses/$businessId/stay/bookings',
      data: request.toMap(),
    )).data!;
    return BookingModel.fromMap(data);
  }

  Future<AppointmentModel> createAppointment({
    required String businessId,
    required CreateAppointmentRequest request,
  }) async {
    final data = (await _client.post(
      '/v1/businesses/$businessId/service/appointments',
      data: request.toMap(),
    )).data!;
    return AppointmentModel.fromMap(data);
  }
}
