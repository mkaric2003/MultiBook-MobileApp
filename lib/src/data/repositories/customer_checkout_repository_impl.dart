import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/rest_repository_executor.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/data_sources/customer_checkout_api_data_source.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/data/models/create_appointment_request.dart';
import 'package:multibook/src/data/models/create_booking_request.dart';
import 'package:multibook/src/domain/repositories/customer_checkout_repository.dart';

@LazySingleton(as: CustomerCheckoutRepository)
class CustomerCheckoutRepositoryImpl implements CustomerCheckoutRepository {
  CustomerCheckoutRepositoryImpl(this._source, this._executor);
  final CustomerCheckoutApiDataSource _source;
  final RestRepositoryExecutor _executor;
  @override
  Future<Result<BookingModel>> createBooking(
    String businessId,
    CreateBookingRequest request,
  ) => _executor.execute(
    () => _source.createBooking(businessId: businessId, request: request),
  );
  @override
  Future<Result<AppointmentModel>> createAppointment(
    String businessId,
    CreateAppointmentRequest request,
  ) => _executor.execute(
    () => _source.createAppointment(businessId: businessId, request: request),
  );
}
