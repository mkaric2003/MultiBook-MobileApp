import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/data/models/business_review_model.dart';
import 'package:aquabook/src/data/repositories/saved_business_repository.dart';
import 'package:aquabook/src/data/repositories/recently_viewed_repository.dart';
import 'package:aquabook/src/data/repositories/review_repository.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/cubit/stay_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class StayDetailCubit extends Cubit<StayDetailState> {
  StayDetailCubit(
    this._businessRepository,
    this._savedRepository,
    this._recentlyViewedRepository,
    this._reviewRepository,
  ) : super(const StayDetailState());

  final BusinessRepository _businessRepository;
  final SavedBusinessRepository _savedRepository;
  final RecentlyViewedRepository _recentlyViewedRepository;
  final ReviewRepository _reviewRepository;

  Future<void> loadStay(String businessId) async {
    emit(const StayDetailState(isLoading: true));
    try {
      final business = await _businessRepository.getBusiness(
        businessId: businessId,
      );
      if (business == null) {
        emit(const StayDetailState(errorMessage: 'This stay is unavailable.'));
        return;
      }
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
    } on BusinessException catch (error) {
      emit(StayDetailState(errorMessage: error.message));
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
