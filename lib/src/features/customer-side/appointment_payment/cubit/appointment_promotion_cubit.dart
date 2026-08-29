import 'dart:async';
import 'dart:developer';

import 'package:multibook/src/data/repositories/promotion_repository.dart';
import 'package:multibook/src/features/customer-side/appointment_payment/cubit/appointment_promotion_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppointmentPromotionCubit extends Cubit<AppointmentPromotionState> {
  AppointmentPromotionCubit(this._promotionRepository)
    : super(const AppointmentPromotionState());

  final PromotionRepository _promotionRepository;

  Future<void> load(String businessId, {String? promoCode}) async {
    emit(AppointmentPromotionState(isLoading: true, promotion: state.promotion));
    try {
      final promotion = await _promotionRepository.getActiveForBusiness(
        businessId,
        promoCode: promoCode,
      );
      if (!isClosed) {
        emit(AppointmentPromotionState(promotion: promotion));
      }
    } catch (error, stackTrace) {
      log(
        'Could not load appointment promotion.',
        name: 'AppointmentPromotionCubit',
        error: error,
        stackTrace: stackTrace,
      );
      if (!isClosed) emit(const AppointmentPromotionState());
    }
  }
}
