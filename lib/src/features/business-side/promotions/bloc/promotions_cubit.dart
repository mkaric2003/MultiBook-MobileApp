import 'dart:async';
import 'package:multibook/src/data/repositories/business_repository.dart';
import 'package:multibook/src/data/repositories/promotion_repository.dart';
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart';
import 'package:multibook/src/features/business-side/promotions/bloc/promotions_state.dart';
import 'package:multibook/src/features/business-side/promotions/domain/models/promotion_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PromotionsCubit extends Cubit<PromotionsState> {
  PromotionsCubit(this._businesses, this._users, this._promotions)
    : super(const PromotionsState());
  final BusinessRepository _businesses;
  final UserProfileUseCase _users;
  final PromotionRepository _promotions;
  StreamSubscription<List<PromotionModel>>? _subscription;
  Future<void> load() async {
    final user = await _users.getCurrentUser();
    final business = user?.selectedBusinessId == null
        ? await _businesses.getFirstOwnedBusiness()
        : await _businesses.getBusiness(businessId: user!.selectedBusinessId!);
    if (business == null) {
      emit(const PromotionsState(loading: false));
      return;
    }
    _subscription?.cancel();
    _subscription = _promotions
        .watchForBusiness(business.id)
        .listen(
          (items) => emit(
            PromotionsState(
              loading: false,
              business: business,
              promotions: items,
            ),
          ),
        );
  }

  Future<void> toggle(PromotionModel promotion, bool active) =>
      _promotions.setActive(promotion, active);
  Future<void> remove(PromotionModel promotion) =>
      _promotions.delete(promotion);
  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
