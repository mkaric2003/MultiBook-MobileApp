import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/payment_methods_repository.dart';

@injectable
class DeletePaymentMethodUseCase {
  DeletePaymentMethodUseCase(this._repository);

  final PaymentMethodsRepository _repository;

  Future<Result<void>> execute(String paymentMethodId) =>
      _repository.deletePaymentMethod(paymentMethodId);
}
