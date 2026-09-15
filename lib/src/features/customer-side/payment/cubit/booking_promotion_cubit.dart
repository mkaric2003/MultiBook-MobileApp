import 'dart:developer';

import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/use_cases/promotions/get_active_promotion_use_case.dart';
import 'package:multibook/src/features/customer-side/payment/cubit/booking_promotion_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class BookingPromotionCubit extends Cubit<BookingPromotionState> {
  BookingPromotionCubit(this._getActivePromotion)
    : super(const BookingPromotionState());

  final GetActivePromotionUseCase _getActivePromotion;

  Future<void> load(String businessId) async {
    try {
      final result = await _getActivePromotion.execute(businessId);
      if (!isClosed) {
        switch (result) {
          case Success(value: final promotion):
            emit(BookingPromotionState(promotion: promotion));
          case FailureResult():
            break;
        }
      }
    } catch (error, stackTrace) {
      log(
        'Could not load booking promotion.',
        name: 'BookingPromotionCubit',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
