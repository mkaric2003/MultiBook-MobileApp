import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/booking_list_response.dart';
import 'package:multibook/src/domain/repositories/provider_bookings_repository.dart';

@injectable
class GetProviderBookingsUseCase {
  GetProviderBookingsUseCase(this._repository);
  final ProviderBookingsRepository _repository;
  Future<Result<BookingListResponse>> execute({
    required String businessId,
    String? status,
    String? cursor,
  }) => _repository.getBookings(
    businessId: businessId,
    status: status,
    cursor: cursor,
  );
}
