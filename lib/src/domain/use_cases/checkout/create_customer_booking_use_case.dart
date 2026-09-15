import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/data/models/create_booking_request.dart';
import 'package:multibook/src/domain/repositories/customer_checkout_repository.dart';

@injectable
class CreateCustomerBookingUseCase {
  CreateCustomerBookingUseCase(this._repository);

  final CustomerCheckoutRepository _repository;

  Future<Result<BookingModel>> execute(
    String businessId,
    CreateBookingRequest request,
  ) => _repository.createBooking(businessId, request);
}
