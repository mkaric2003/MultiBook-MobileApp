import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/appointment_list_response.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/models/booking_list_response.dart';
import 'package:multibook/src/data/models/booking_model.dart';

abstract class ProviderBookingsRepository {
  Future<Result<BookingListResponse>> getBookings({
    required String businessId,
    String? status,
    String? cursor,
    int pageSize = 20,
  });
  Future<Result<BookingModel>> updateBookingStatus({
    required String bookingId,
    required String status,
  });
  Future<Result<AppointmentListResponse>> getAppointments({
    required String businessId,
    String? status,
    String? cursor,
    int pageSize = 20,
  });
  Future<Result<AppointmentModel>> updateAppointmentStatus({
    required String appointmentId,
    required String status,
  });
}
