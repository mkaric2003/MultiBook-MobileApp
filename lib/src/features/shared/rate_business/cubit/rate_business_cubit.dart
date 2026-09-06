import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/use_cases/reviews/create_review_use_case.dart';
import 'package:multibook/src/features/shared/rate_business/cubit/rate_business_state.dart';
import 'package:multibook/src/features/shared/rate_business/domain/models/rate_business_target.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RateBusinessCubit extends Cubit<RateBusinessState> {
  RateBusinessCubit(this._createReview) : super(const RateBusinessState());

  final CreateReviewUseCase _createReview;

  Future<void> submit({
    required RateBusinessTarget target,
    required int rating,
    String? comment,
  }) async {
    if (rating < 1 || rating > 5 || state.isSubmitting) return;
    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    final result = await _createReview.execute(
      target: target,
      rating: rating,
      comment: comment,
    );
    if (result is Success<void>) {
      emit(state.copyWith(isSubmitting: false, isSubmitted: true));
    } else {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'Unable to submit review.',
        ),
      );
    }
  }
}
