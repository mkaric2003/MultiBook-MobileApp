import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/features/business-side/promotions/domain/enums/promotion_type.dart';
import 'package:multibook/src/features/business-side/promotions/domain/models/promotion_model.dart';

abstract class PromotionsRepository {
  Future<Result<List<PromotionModel>>> getBusinessPromotions(String businessId);

  Future<Result<PromotionModel?>> getActivePromotion(
    String businessId, {
    String? promoCode,
  });

  Future<Result<void>> createPromotion({
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
  });

  Future<Result<void>> setPromotionActive({
    required String businessId,
    required String promotionId,
    required bool isActive,
  });

  Future<Result<void>> deletePromotion({
    required String businessId,
    required String promotionId,
  });
}
