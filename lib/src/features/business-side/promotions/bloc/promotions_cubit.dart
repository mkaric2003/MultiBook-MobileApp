import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/use_cases/businesses/get_owned_businesses_use_case.dart';
import 'package:multibook/src/domain/use_cases/promotions/delete_promotion_use_case.dart';
import 'package:multibook/src/domain/use_cases/promotions/get_business_promotions_use_case.dart';
import 'package:multibook/src/domain/use_cases/promotions/set_promotion_active_use_case.dart';
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart';
import 'package:multibook/src/features/business-side/promotions/bloc/promotions_state.dart';
import 'package:multibook/src/features/business-side/promotions/domain/models/promotion_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PromotionsCubit extends Cubit<PromotionsState> {
  PromotionsCubit(
    this._getOwnedBusinesses,
    this._users,
    this._getPromotions,
    this._setActive,
    this._deletePromotion,
  ) : super(const PromotionsState());
  final GetOwnedBusinessesUseCase _getOwnedBusinesses;
  final UserProfileUseCase _users;
  final GetBusinessPromotionsUseCase _getPromotions;
  final SetPromotionActiveUseCase _setActive;
  final DeletePromotionUseCase _deletePromotion;

  Future<void> load() async {
    final user = await _users.getCurrentUser();
    final businessesResult = await _getOwnedBusinesses.execute(
      forceRefresh: true,
    );
    final businesses = switch (businessesResult) {
      Success(value: final items) => items,
      FailureResult() => null,
    };
    if (businesses == null) {
      emit(const PromotionsState(loading: false));
      return;
    }
    final selectedId = user?.selectedBusinessId;
    final business =
        businesses.where((item) => item.id == selectedId).firstOrNull ??
        businesses.firstOrNull;
    if (business == null) {
      emit(const PromotionsState(loading: false));
      return;
    }
    final promotionsResult = await _getPromotions.execute(business.id);
    final promotions = switch (promotionsResult) {
      Success(value: final items) => items,
      FailureResult() => <PromotionModel>[],
    };
    if (!isClosed) {
      emit(
        PromotionsState(
          loading: false,
          business: business,
          promotions: promotions,
        ),
      );
    }
  }

  Future<void> toggle(PromotionModel promotion, bool active) async {
    await _setActive.execute(
      businessId: promotion.businessId,
      promotionId: promotion.id,
      isActive: active,
    );
    await load();
  }

  Future<void> remove(PromotionModel promotion) async {
    await _deletePromotion.execute(
      businessId: promotion.businessId,
      promotionId: promotion.id,
    );
    await load();
  }
}
