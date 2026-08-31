import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/rest_repository_executor.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/data_sources/customer_bookings_api_data_source.dart';
import 'package:multibook/src/data/models/booking_list_response.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/data/models/stay_availability_response.dart';
import 'package:multibook/src/domain/repositories/customer_bookings_repository.dart';

@LazySingleton(as: CustomerBookingsRepository)
class CustomerBookingsRepositoryImpl implements CustomerBookingsRepository {
  CustomerBookingsRepositoryImpl(this._source, this._executor);

  final CustomerBookingsApiDataSource _source;
  final RestRepositoryExecutor _executor;

  @override
  Future<Result<BookingListResponse>> getBookings({
    String? businessId,
    String? cursor,
    int pageSize = 20,
  }) => _executor.execute(
    () => _source.getBookings(
      businessId: businessId,
      cursor: cursor,
      pageSize: pageSize,
    ),
  );

  @override
  Future<Result<BookingModel>> cancelBooking(String bookingId) =>
      _executor.execute(() => _source.cancelBooking(bookingId));

  @override
  Future<Result<StayAvailabilityResponse>> getAvailability({
    required String businessId,
    String? roomTypeId,
  }) => _executor.execute(
    () =>
        _source.getAvailability(businessId: businessId, roomTypeId: roomTypeId),
  );
}
