import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/rest_repository_executor.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/data_sources/promotions_api_data_source.dart';
import 'package:multibook/src/domain/repositories/promotions_repository.dart';
import 'package:multibook/src/features/business-side/promotions/domain/enums/promotion_type.dart';
import 'package:multibook/src/features/business-side/promotions/domain/models/promotion_model.dart';

@LazySingleton(as: PromotionsRepository)
class PromotionsRepositoryImpl implements PromotionsRepository {
  PromotionsRepositoryImpl(this._source, this._executor);

  final PromotionsApiDataSource _source;
  final RestRepositoryExecutor _executor;

  @override
  Future<Result<List<PromotionModel>>> getBusinessPromotions(
    String businessId,
  ) => _executor.execute(() => _source.getBusinessPromotions(businessId));

  @override
  Future<Result<PromotionModel?>> getActivePromotion(
    String businessId, {
    String? promoCode,
  }) => _executor.execute(
    () => _source.getActivePromotion(businessId, promoCode: promoCode),
  );

  @override
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
  }) => _executor.execute(
    () => _source.createPromotion(
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
    ),
  );

  @override
  Future<Result<void>> setPromotionActive({
    required String businessId,
    required String promotionId,
    required bool isActive,
  }) => _executor.execute(
    () => _source.setPromotionActive(
      businessId: businessId,
      promotionId: promotionId,
      isActive: isActive,
    ),
  );

  @override
  Future<Result<void>> deletePromotion({
    required String businessId,
    required String promotionId,
  }) => _executor.execute(
    () => _source.deletePromotion(
      businessId: businessId,
      promotionId: promotionId,
    ),
  );
}
