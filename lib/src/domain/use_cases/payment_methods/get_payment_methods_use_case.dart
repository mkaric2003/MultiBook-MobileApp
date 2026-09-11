import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/payment_methods_repository.dart';
import 'package:multibook/src/features/customer-side/payment_methods/domain/models/saved_payment_method_model.dart';

@injectable
class GetPaymentMethodsUseCase {
  GetPaymentMethodsUseCase(this._repository);

  final PaymentMethodsRepository _repository;

  Future<Result<List<SavedPaymentMethodModel>>> execute() =>
      _repository.getPaymentMethods();
}
