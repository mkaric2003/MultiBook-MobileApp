import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/networking/api_client.dart';
import 'package:multibook/src/features/customer-side/payment_methods/domain/enums/saved_card_brand.dart';
import 'package:multibook/src/features/customer-side/payment_methods/domain/models/saved_payment_method_model.dart';

@lazySingleton
class PaymentMethodsApiDataSource {
  PaymentMethodsApiDataSource(this._client);

  final ApiClient _client;

  Future<List<SavedPaymentMethodModel>> getPaymentMethods() async {
    final response = await _client.get('/v1/payment-methods');
    return (response.data!['items'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(SavedPaymentMethodModelMapper.fromMap)
        .toList();
  }

  Future<void> savePaymentMethod({
    required SavedCardBrand brand,
    required String last4,
    required int expiryMonth,
    required int expiryYear,
    required String holderName,
  }) async {
    await _client.post(
      '/v1/payment-methods',
      data: {
        'brand': brand.name,
        'last4': last4,
        'expiryMonth': expiryMonth,
        'expiryYear': expiryYear,
        'holderName': holderName.trim(),
      },
    );
  }

  Future<void> setDefaultPaymentMethod(String paymentMethodId) async {
    await _client.patch(
      '/v1/payment-methods/$paymentMethodId/default',
      data: const {},
    );
  }

  Future<void> deletePaymentMethod(String paymentMethodId) async {
    await _client.delete('/v1/payment-methods/$paymentMethodId');
  }
}
