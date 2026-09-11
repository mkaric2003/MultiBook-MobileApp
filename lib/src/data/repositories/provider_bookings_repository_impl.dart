import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/rest_repository_executor.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/data_sources/provider_bookings_api_data_source.dart';
import 'package:multibook/src/data/models/appointment_list_response.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/models/booking_list_response.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/domain/repositories/provider_bookings_repository.dart';

@LazySingleton(as: ProviderBookingsRepository)
class ProviderBookingsRepositoryImpl implements ProviderBookingsRepository {
  ProviderBookingsRepositoryImpl(this._source, this._executor);
  final ProviderBookingsApiDataSource _source;
  final RestRepositoryExecutor _executor;
  @override
  Future<Result<BookingListResponse>> getBookings({
    required String businessId,
    String? status,
    String? cursor,
    int pageSize = 20,
  }) => _executor.execute(
    () => _source.getBookings(
      businessId: businessId,
      status: status,
      cursor: cursor,
      pageSize: pageSize,
    ),
  );
  @override
  Future<Result<BookingModel>> updateBookingStatus({
    required String bookingId,
    required String status,
  }) => _executor.execute(
    () => _source.updateBookingStatus(bookingId: bookingId, status: status),
  );
  @override
  Future<Result<AppointmentListResponse>> getAppointments({
    required String businessId,
    String? status,
    String? cursor,
    int pageSize = 20,
  }) => _executor.execute(
    () => _source.getAppointments(
      businessId: businessId,
      status: status,
      cursor: cursor,
      pageSize: pageSize,
    ),
  );
  @override
  Future<Result<AppointmentModel>> updateAppointmentStatus({
    required String appointmentId,
    required String status,
  }) => _executor.execute(
    () => _source.updateAppointmentStatus(
      appointmentId: appointmentId,
      status: status,
    ),
  );
}
