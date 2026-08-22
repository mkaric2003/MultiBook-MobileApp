import 'package:aquabook/src/data/repositories/review_repository.dart';
import 'package:aquabook/src/features/shared/rate_business/cubit/rate_business_state.dart';
import 'package:aquabook/src/features/shared/rate_business/domain/models/rate_business_target.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RateBusinessCubit extends Cubit<RateBusinessState> {
  RateBusinessCubit(this._reviewRepository) : super(const RateBusinessState());

  final ReviewRepository _reviewRepository;

  Future<void> submit({
    required RateBusinessTarget target,
    required int rating,
    String? comment,
  }) async {
    if (rating < 1 || rating > 5 || state.isSubmitting) return;
    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    try {
      await _reviewRepository.createReview(
        target: target,
        rating: rating,
        comment: comment,
      );
      emit(state.copyWith(isSubmitting: false, isSubmitted: true));
    } on ReviewException catch (error) {
      emit(state.copyWith(isSubmitting: false, errorMessage: error.message));
    }
  }
}
