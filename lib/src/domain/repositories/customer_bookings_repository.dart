import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/booking_list_response.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/data/models/stay_availability_response.dart';

abstract class CustomerBookingsRepository {
  Future<Result<BookingListResponse>> getBookings({
    String? businessId,
    String? cursor,
    int pageSize = 20,
  });

  Future<Result<BookingModel>> cancelBooking(String bookingId);

  Future<Result<StayAvailabilityResponse>> getAvailability({
    required String businessId,
    String? roomTypeId,
  });
}
