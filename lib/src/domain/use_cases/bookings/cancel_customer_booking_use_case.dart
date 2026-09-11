import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/domain/repositories/customer_bookings_repository.dart';

@injectable
class CancelCustomerBookingUseCase {
  CancelCustomerBookingUseCase(this._repository);

  final CustomerBookingsRepository _repository;

  Future<Result<BookingModel>> execute(String bookingId) =>
      _repository.cancelBooking(bookingId);
}
