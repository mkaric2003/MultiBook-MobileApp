import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/appointment_list_response.dart';
import 'package:multibook/src/domain/repositories/provider_bookings_repository.dart';

@injectable
class GetProviderAppointmentsUseCase {
  GetProviderAppointmentsUseCase(this._repository);
  final ProviderBookingsRepository _repository;
  Future<Result<AppointmentListResponse>> execute({
    required String businessId,
    String? status,
    String? cursor,
  }) => _repository.getAppointments(
    businessId: businessId,
    status: status,
    cursor: cursor,
  );
}
