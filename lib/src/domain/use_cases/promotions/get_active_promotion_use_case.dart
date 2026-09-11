import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/promotions_repository.dart';
import 'package:multibook/src/features/business-side/promotions/domain/models/promotion_model.dart';

@injectable
class GetActivePromotionUseCase {
  GetActivePromotionUseCase(this._repository);

  final PromotionsRepository _repository;

  Future<Result<PromotionModel?>> execute(
    String businessId, {
    String? promoCode,
  }) => _repository.getActivePromotion(businessId, promoCode: promoCode);
}
