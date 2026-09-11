import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/features/customer-side/payment_methods/domain/enums/saved_card_brand.dart';
import 'package:multibook/src/features/customer-side/payment_methods/domain/models/saved_payment_method_model.dart';

abstract class PaymentMethodsRepository {
  Future<Result<List<SavedPaymentMethodModel>>> getPaymentMethods();

  Future<Result<void>> savePaymentMethod({
    required SavedCardBrand brand,
    required String last4,
    required int expiryMonth,
    required int expiryYear,
    required String holderName,
  });

  Future<Result<void>> setDefaultPaymentMethod(String paymentMethodId);

  Future<Result<void>> deletePaymentMethod(String paymentMethodId);
}
