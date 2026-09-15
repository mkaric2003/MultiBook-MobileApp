import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/promotions_repository.dart';

@injectable
class DeletePromotionUseCase {
  DeletePromotionUseCase(this._repository);

  final PromotionsRepository _repository;

  Future<Result<void>> execute({
    required String businessId,
    required String promotionId,
  }) => _repository.deletePromotion(
    businessId: businessId,
    promotionId: promotionId,
  );
}
