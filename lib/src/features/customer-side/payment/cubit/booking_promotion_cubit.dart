import 'dart:developer';

import 'package:aquabook/src/data/repositories/promotion_repository.dart';
import 'package:aquabook/src/features/customer-side/payment/cubit/booking_promotion_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class BookingPromotionCubit extends Cubit<BookingPromotionState> {
  BookingPromotionCubit(this._promotionRepository)
    : super(const BookingPromotionState());

  final PromotionRepository _promotionRepository;

  Future<void> load(String businessId) async {
    try {
      final promotion = await _promotionRepository.getActiveForBusiness(
        businessId,
      );
      if (!isClosed) emit(BookingPromotionState(promotion: promotion));
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
