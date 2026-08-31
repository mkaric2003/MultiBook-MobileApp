import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/appointment_list_response.dart';
import 'package:multibook/src/domain/repositories/customer_appointments_repository.dart';

@injectable
class GetCustomerAppointmentsUseCase {
  GetCustomerAppointmentsUseCase(this._repository);

  final CustomerAppointmentsRepository _repository;

  Future<Result<AppointmentListResponse>> execute({
    String? cursor,
    int pageSize = 20,
  }) => _repository.getAppointments(cursor: cursor, pageSize: pageSize);
}
