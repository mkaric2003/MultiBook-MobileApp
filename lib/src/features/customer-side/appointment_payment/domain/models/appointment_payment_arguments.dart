import 'package:multibook/src/features/business-side/promotions/domain/models/promotion_model.dart';
import 'package:multibook/src/features/business-side/promotions/domain/promotion_price_calculator.dart';
import 'package:multibook/src/features/customer-side/review_appointment/domain/models/review_appointment_arguments.dart';

class AppointmentPaymentArguments {
  const AppointmentPaymentArguments({required this.review});

  final ReviewAppointmentArguments review;

  int get serviceCost =>
      review.offerings.fold(0, (total, offering) => total + offering.price);

  int discount(PromotionModel? promotion) => PromotionPriceCalculator.discount(
    subtotal: serviceCost,
    promotion: promotion,
  );

  int discountedServiceCost(PromotionModel? promotion) =>
      serviceCost - discount(promotion);

  double serviceFeeWithPromotion(PromotionModel? promotion) =>
      discountedServiceCost(promotion) * 0.085;

  double taxesWithPromotion(PromotionModel? promotion) =>
      (discountedServiceCost(promotion) + serviceFeeWithPromotion(promotion)) *
      0.1;

  double totalWithPromotion(PromotionModel? promotion) =>
      discountedServiceCost(promotion) +
      serviceFeeWithPromotion(promotion) +
      taxesWithPromotion(promotion);

  double get serviceFee => serviceFeeWithPromotion(null);

  double get taxes => taxesWithPromotion(null);

  double get total => totalWithPromotion(null);
}
