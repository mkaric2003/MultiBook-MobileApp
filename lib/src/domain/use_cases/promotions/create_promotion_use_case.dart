import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/promotions_repository.dart';
import 'package:multibook/src/features/business-side/promotions/domain/enums/promotion_type.dart';

@injectable
class CreatePromotionUseCase {
  CreatePromotionUseCase(this._repository);

  final PromotionsRepository _repository;

  Future<Result<void>> execute({
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
  }) => _repository.createPromotion(
    businessId: businessId,
    name: name,
    type: type,
    value: value,
    startsAt: startsAt,
    endsAt: endsAt,
    code: code,
    minimumAmount: minimumAmount,
    minimumNights: minimumNights,
    usageLimit: usageLimit,
  );
}
