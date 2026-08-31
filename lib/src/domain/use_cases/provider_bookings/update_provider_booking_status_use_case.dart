import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/domain/repositories/provider_bookings_repository.dart';

@injectable
class UpdateProviderBookingStatusUseCase {
  UpdateProviderBookingStatusUseCase(this._repository);
  final ProviderBookingsRepository _repository;
  Future<Result<BookingModel>> execute({
    required String bookingId,
    required String status,
  }) => _repository.updateBookingStatus(bookingId: bookingId, status: status);
}
