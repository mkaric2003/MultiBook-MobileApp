import 'package:multibook/src/features/business-side/promotions/domain/enums/promotion_type.dart';
import 'package:multibook/src/features/business-side/promotions/domain/models/promotion_model.dart';

class PromotionPriceCalculator {
  const PromotionPriceCalculator._();

  static int discount({
    required int subtotal,
    PromotionModel? promotion,
    int? nights,
  }) {
    final now = DateTime.now();
    if (promotion == null ||
        !promotion.isActive ||
        promotion.startsAt.isAfter(now) ||
        promotion.endsAt.isBefore(now) ||
        subtotal < promotion.minimumAmount ||
        (promotion.minimumNights > 0 &&
            (nights ?? 0) < promotion.minimumNights)) {
      return 0;
    }
    return switch (promotion.type) {
      PromotionType.percentage =>
        (subtotal * promotion.value / 100).round().clamp(0, subtotal),
      PromotionType.fixedAmount => promotion.value.clamp(0, subtotal),
      PromotionType.couponCode =>
        (subtotal * promotion.value / 100).round().clamp(0, subtotal),
    };
  }
}
