import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/data/models/create_appointment_request.dart';
import 'package:multibook/src/data/models/create_booking_request.dart';

abstract class CustomerCheckoutRepository {
  Future<Result<BookingModel>> createBooking(
    String businessId,
    CreateBookingRequest request,
  );
  Future<Result<AppointmentModel>> createAppointment(
    String businessId,
    CreateAppointmentRequest request,
  );
}
