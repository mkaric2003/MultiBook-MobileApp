import 'package:multibook/src/features/business-side/promotions/domain/models/promotion_model.dart';

class AppointmentPromotionState {
  const AppointmentPromotionState({
    this.promotion,
    this.isLoading = false,
  });

  final PromotionModel? promotion;
  final bool isLoading;
}
