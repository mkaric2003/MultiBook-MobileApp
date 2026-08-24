import 'package:aquabook/src/features/customer-side/payment_methods/domain/enums/saved_card_brand.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'saved_payment_method_model.mapper.dart';

@MappableClass()
final class SavedPaymentMethodModel with SavedPaymentMethodModelMappable {
  const SavedPaymentMethodModel({
    required this.id,
    required this.userId,
    required this.brand,
    required this.last4,
    required this.expiryMonth,
    required this.expiryYear,
    required this.holderName,
    required this.isDefault,
    this.createdAt,
  });

  final String id;
  final String userId;
  final SavedCardBrand brand;
  final String last4;
  final int expiryMonth;
  final int expiryYear;
  final String holderName;
  final bool isDefault;
  final DateTime? createdAt;

  String get maskedNumber => '•••• •••• •••• $last4';
  String get expiry =>
      '${expiryMonth.toString().padLeft(2, '0')}/${(expiryYear % 100).toString().padLeft(2, '0')}';
}
