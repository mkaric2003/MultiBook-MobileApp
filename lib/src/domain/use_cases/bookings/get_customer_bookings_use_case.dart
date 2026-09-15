import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/booking_list_response.dart';
import 'package:multibook/src/domain/repositories/customer_bookings_repository.dart';

@injectable
class GetCustomerBookingsUseCase {
  GetCustomerBookingsUseCase(this._repository);

  final CustomerBookingsRepository _repository;

  Future<Result<BookingListResponse>> execute({
    String? businessId,
    String? cursor,
    int pageSize = 20,
  }) => _repository.getBookings(
    businessId: businessId,
    cursor: cursor,
    pageSize: pageSize,
  );
}
