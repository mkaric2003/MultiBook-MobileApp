import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/booking_list_response.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/data/models/stay_availability_response.dart';
import 'package:multibook/src/domain/repositories/customer_bookings_repository.dart';

@injectable
class CustomerBookingsUseCase {
  CustomerBookingsUseCase(this._repository);

  final CustomerBookingsRepository _repository;

  Future<Result<BookingListResponse>> getBookings({
    String? businessId,
    String? cursor,
    int pageSize = 20,
  }) => _repository.getBookings(
    businessId: businessId,
    cursor: cursor,
    pageSize: pageSize,
  );

  Future<Result<BookingModel>> cancelBooking(String bookingId) =>
      _repository.cancelBooking(bookingId);

  Future<Result<StayAvailabilityResponse>> getAvailability({
    required String businessId,
    String? roomTypeId,
  }) => _repository.getAvailability(
    businessId: businessId,
    roomTypeId: roomTypeId,
  );
}
