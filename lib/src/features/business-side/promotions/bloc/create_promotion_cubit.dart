import 'package:multibook/src/data/repositories/promotion_repository.dart';
import 'package:multibook/src/features/business-side/promotions/bloc/create_promotion_state.dart';
import 'package:multibook/src/features/business-side/promotions/domain/enums/promotion_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreatePromotionCubit extends Cubit<CreatePromotionState> {
  CreatePromotionCubit(this._repository) : super(const CreatePromotionState());
  final PromotionRepository _repository;

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
    try {
      await _repository.create(
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
      if (!isClosed) {
        emit(const CreatePromotionState());
      }
      return true;
    } catch (_) {
      if (!isClosed) {
        emit(const CreatePromotionState(errorMessage: 'createPromotionFailed'));
      }
      return false;
    }
  }
}
