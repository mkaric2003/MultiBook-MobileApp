import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/models/create_appointment_request.dart';
import 'package:multibook/src/domain/repositories/customer_checkout_repository.dart';

@injectable
class CreateCustomerAppointmentUseCase {
  CreateCustomerAppointmentUseCase(this._repository);

  final CustomerCheckoutRepository _repository;

  Future<Result<AppointmentModel>> execute(
    String businessId,
    CreateAppointmentRequest request,
  ) => _repository.createAppointment(businessId, request);
}
