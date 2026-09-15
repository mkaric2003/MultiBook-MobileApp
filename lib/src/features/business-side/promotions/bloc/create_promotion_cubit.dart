import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/use_cases/promotions/create_promotion_use_case.dart';
import 'package:multibook/src/features/business-side/promotions/bloc/create_promotion_state.dart';
import 'package:multibook/src/features/business-side/promotions/domain/enums/promotion_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreatePromotionCubit extends Cubit<CreatePromotionState> {
  CreatePromotionCubit(this._createPromotion)
    : super(const CreatePromotionState());
  final CreatePromotionUseCase _createPromotion;

  Future<bool> create({
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
  }) async {
    emit(const CreatePromotionState(submitting: true));
    final result = await _createPromotion.execute(
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
    if (result is Success) {
      if (!isClosed) emit(const CreatePromotionState());
      return true;
    }
    if (!isClosed) {
      emit(const CreatePromotionState(errorMessage: 'createPromotionFailed'));
    }
    return false;
  }
}
