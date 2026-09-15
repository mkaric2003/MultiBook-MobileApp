import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/features/business-side/promotions/domain/models/promotion_model.dart';

class PromotionsState {
  const PromotionsState({
    this.loading = true,
    this.business,
    this.promotions = const [],
  });
  final bool loading;
  final BusinessModel? business;
  final List<PromotionModel> promotions;
}
