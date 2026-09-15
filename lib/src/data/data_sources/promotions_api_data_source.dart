import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/networking/api_client.dart';
import 'package:multibook/src/features/business-side/promotions/domain/enums/promotion_type.dart';
import 'package:multibook/src/features/business-side/promotions/domain/models/promotion_model.dart';

@lazySingleton
class PromotionsApiDataSource {
  PromotionsApiDataSource(this._client);

  final ApiClient _client;

  Future<List<PromotionModel>> getBusinessPromotions(String businessId) async {
    final response = await _client.get('/v1/businesses/$businessId/promotions');
    return (response.data!['items'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(PromotionModelMapper.fromMap)
        .toList();
  }

  Future<PromotionModel?> getActivePromotion(
    String businessId, {
    String? promoCode,
  }) async {
    final response = await _client.get(
      '/v1/businesses/$businessId/promotions/active',
      queryParameters: {
        if (promoCode?.trim().isNotEmpty == true)
          'promo_code': promoCode!.trim(),
      },
    );
    final promotion = response.data!['promotion'];
    return promotion == null
        ? null
        : PromotionModelMapper.fromMap(promotion as Map<String, dynamic>);
  }

  Future<void> createPromotion({
    required String businessId,
    required String name,
    required PromotionType type,
    required int value,
    required DateTime startsAt,
    required DateTime endsAt,
    String? code,
    required int minimumAmount,
    required int minimumNights,
    int? usageLimit,
  }) async {
    await _client.post(
      '/v1/businesses/$businessId/promotions',
      data: {
        'name': name.trim(),
        'type': type.name,
        'value': value,
        'startsAt': startsAt.toUtc().toIso8601String(),
        'endsAt': endsAt.toUtc().toIso8601String(),
        'code': code?.trim().isEmpty == true ? null : code?.trim(),
        'minimumAmount': minimumAmount,
        'minimumNights': minimumNights,
        'usageLimit': usageLimit,
      },
    );
  }

  Future<void> setPromotionActive({
    required String businessId,
    required String promotionId,
    required bool isActive,
  }) async {
    await _client.patch(
      '/v1/businesses/$businessId/promotions/$promotionId/active',
      data: {'isActive': isActive},
    );
  }

  Future<void> deletePromotion({
    required String businessId,
    required String promotionId,
  }) async {
    await _client.delete('/v1/businesses/$businessId/promotions/$promotionId');
  }
}
