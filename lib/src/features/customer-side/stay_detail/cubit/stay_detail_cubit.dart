import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/use_cases/customer_discovery/get_business_detail_use_case.dart';
import 'package:multibook/src/data/models/business_review_model.dart';
import 'package:multibook/src/data/repositories/saved_business_repository.dart';
import 'package:multibook/src/data/repositories/recently_viewed_repository.dart';
import 'package:multibook/src/data/repositories/review_repository.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:multibook/src/features/customer-side/stay_detail/cubit/stay_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class StayDetailCubit extends Cubit<StayDetailState> {
  StayDetailCubit(
    this._getBusinessDetail,
    this._savedRepository,
    this._recentlyViewedRepository,
    this._reviewRepository,
  ) : super(const StayDetailState());

  final GetBusinessDetailUseCase _getBusinessDetail;
  final SavedBusinessRepository _savedRepository;
  final RecentlyViewedRepository _recentlyViewedRepository;
  final ReviewRepository _reviewRepository;

  Future<void> loadStay(String businessId) async {
    emit(const StayDetailState(isLoading: true));
    try {
      final result = await _getBusinessDetail.execute(businessId);
      if (result is! Success<BusinessModel>) {
        emit(const StayDetailState(errorMessage: 'This stay is unavailable.'));
        return;
      }
      final business = result.value;
      await _recentlyViewedRepository.recordBusinessView(business);
      final results = await Future.wait([
        _savedRepository.isSaved(business.id),
        _reviewRepository.getPreviewReviews(business.id),
      ]);
      emit(
        StayDetailState(
          business: business,
          isSaved: results[0] as bool,
          reviews: results[1] as List<BusinessReviewModel>,
        ),
      );
    } catch (_) {
      emit(const StayDetailState(errorMessage: 'This stay is unavailable.'));
    }
  }

  Future<void> toggleSaved(StayListing stay) async {
    final wasSaved = state.isSaved;
    emit(
      StayDetailState(
        business: state.business,
        isSaved: !wasSaved,
        reviews: state.reviews,
      ),
    );
    await _savedRepository.toggle(stay, wasSaved);
  }
}
