import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/payment_methods_repository.dart';
import 'package:multibook/src/features/customer-side/payment_methods/domain/enums/saved_card_brand.dart';

@injectable
class SavePaymentMethodUseCase {
  SavePaymentMethodUseCase(this._repository);

  final PaymentMethodsRepository _repository;

  Future<Result<void>> execute({
    required String cardNumber,
    required String expiry,
    required String holderName,
  }) {
    final digits = cardNumber.replaceAll(RegExp(r'\D'), '');
    final expiryParts = expiry.split('/');
    if (digits.length < 4 || expiryParts.length != 2) {
      return Future.value(
        const FailureResult(ValidationFailure('Card metadata is invalid.')),
      );
    }
    final expiryMonth = int.tryParse(expiryParts.first);
    final shortYear = int.tryParse(expiryParts.last);
    if (expiryMonth == null || shortYear == null) {
      return Future.value(
        const FailureResult(ValidationFailure('Card expiry is invalid.')),
      );
    }
    return _repository.savePaymentMethod(
      brand: _brand(digits),
      last4: digits.substring(digits.length - 4),
      expiryMonth: expiryMonth,
      expiryYear: 2000 + shortYear,
      holderName: holderName.trim(),
    );
  }

  SavedCardBrand _brand(String number) => number.startsWith('4')
      ? SavedCardBrand.visa
      : number.startsWith(RegExp(r'5[1-5]'))
      ? SavedCardBrand.mastercard
      : number.startsWith(RegExp(r'3[47]'))
      ? SavedCardBrand.amex
      : SavedCardBrand.other;
}
