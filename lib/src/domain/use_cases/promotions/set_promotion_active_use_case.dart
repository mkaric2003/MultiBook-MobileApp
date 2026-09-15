import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/promotions_repository.dart';

@injectable
class SetPromotionActiveUseCase {
  SetPromotionActiveUseCase(this._repository);

  final PromotionsRepository _repository;

  Future<Result<void>> execute({
    required String businessId,
    required String promotionId,
    required bool isActive,
  }) => _repository.setPromotionActive(
    businessId: businessId,
    promotionId: promotionId,
    isActive: isActive,
  );
}
