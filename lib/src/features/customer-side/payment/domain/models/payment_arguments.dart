import 'package:aquabook/src/data/models/stay_extra_model.dart';
import 'package:aquabook/src/features/business-side/promotions/domain/models/promotion_model.dart';
import 'package:aquabook/src/features/business-side/promotions/domain/promotion_price_calculator.dart';
import 'package:aquabook/src/features/customer-side/review_stay/domain/models/review_stay_arguments.dart';

class PaymentArguments {
  const PaymentArguments({required this.review, required this.selectedExtras});
  final ReviewStayArguments review;
  final List<StayExtraModel> selectedExtras;

  int discount({required int pricePerNight, PromotionModel? promotion}) {
    final booking = review.bookingState;
    final room = booking.nightCount * pricePerNight;
    final extras = selectedExtras.fold(
      0,
      (total, extra) =>
          total + extra.price * (extra.isPerNight ? booking.nightCount : 1),
    );
    return PromotionPriceCalculator.discount(
      subtotal: room + extras,
      promotion: promotion,
      nights: booking.nightCount,
    );
  }
}
