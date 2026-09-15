import 'dart:async';
import 'dart:developer';

import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/use_cases/promotions/get_active_promotion_use_case.dart';
import 'package:multibook/src/features/customer-side/appointment_payment/cubit/appointment_promotion_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppointmentPromotionCubit extends Cubit<AppointmentPromotionState> {
  AppointmentPromotionCubit(this._getActivePromotion)
    : super(const AppointmentPromotionState());

  final GetActivePromotionUseCase _getActivePromotion;

  Future<void> load(String businessId, {String? promoCode}) async {
    emit(
      AppointmentPromotionState(isLoading: true, promotion: state.promotion),
    );
    try {
      final result = await _getActivePromotion.execute(
        businessId,
        promoCode: promoCode,
      );
      if (!isClosed) {
        switch (result) {
          case Success(value: final promotion):
            emit(AppointmentPromotionState(promotion: promotion));
          case FailureResult():
            emit(const AppointmentPromotionState());
        }
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
