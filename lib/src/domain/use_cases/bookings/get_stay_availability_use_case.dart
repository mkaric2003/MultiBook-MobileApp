import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/stay_availability_response.dart';
import 'package:multibook/src/domain/repositories/customer_bookings_repository.dart';

@injectable
class GetStayAvailabilityUseCase {
  GetStayAvailabilityUseCase(this._repository);

  final CustomerBookingsRepository _repository;

  Future<Result<StayAvailabilityResponse>> execute({
    required String businessId,
    String? roomTypeId,
  }) => _repository.getAvailability(
    businessId: businessId,
    roomTypeId: roomTypeId,
  );
}
