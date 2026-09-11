import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/rest_repository_executor.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/data_sources/payment_methods_api_data_source.dart';
import 'package:multibook/src/domain/repositories/payment_methods_repository.dart';
import 'package:multibook/src/features/customer-side/payment_methods/domain/enums/saved_card_brand.dart';
import 'package:multibook/src/features/customer-side/payment_methods/domain/models/saved_payment_method_model.dart';

@LazySingleton(as: PaymentMethodsRepository)
class PaymentMethodsRepositoryImpl implements PaymentMethodsRepository {
  PaymentMethodsRepositoryImpl(this._source, this._executor);

  final PaymentMethodsApiDataSource _source;
  final RestRepositoryExecutor _executor;

  @override
  Future<Result<List<SavedPaymentMethodModel>>> getPaymentMethods() =>
      _executor.execute(_source.getPaymentMethods);

  @override
  Future<Result<void>> savePaymentMethod({
    required SavedCardBrand brand,
    required String last4,
    required int expiryMonth,
    required int expiryYear,
    required String holderName,
  }) => _executor.execute(
    () => _source.savePaymentMethod(
      brand: brand,
      last4: last4,
      expiryMonth: expiryMonth,
      expiryYear: expiryYear,
      holderName: holderName,
    ),
  );

  @override
  Future<Result<void>> setDefaultPaymentMethod(String paymentMethodId) =>
      _executor.execute(() => _source.setDefaultPaymentMethod(paymentMethodId));

  @override
  Future<Result<void>> deletePaymentMethod(String paymentMethodId) =>
      _executor.execute(() => _source.deletePaymentMethod(paymentMethodId));
}
