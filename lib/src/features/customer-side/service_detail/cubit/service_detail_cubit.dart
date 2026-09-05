import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/use_cases/customer_discovery/get_business_detail_use_case.dart';
import 'package:multibook/src/data/models/business_review_model.dart';
import 'package:multibook/src/data/repositories/saved_business_repository.dart';
import 'package:multibook/src/domain/use_cases/recently_viewed/record_recently_viewed_use_case.dart';
import 'package:multibook/src/core/services/recently_viewed_updates_service.dart';
import 'package:multibook/src/data/repositories/review_repository.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:multibook/src/features/customer-side/service_detail/cubit/service_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ServiceDetailCubit extends Cubit<ServiceDetailState> {
  ServiceDetailCubit(
    this._getBusinessDetail,
    this._savedRepository,
    this._recordRecentlyViewed,
    this._recentlyViewedUpdates,
    this._reviewRepository,
  ) : super(const ServiceDetailState());

  final GetBusinessDetailUseCase _getBusinessDetail;
  final SavedBusinessRepository _savedRepository;
  final RecordRecentlyViewedUseCase _recordRecentlyViewed;
  final RecentlyViewedUpdatesService _recentlyViewedUpdates;
  final ReviewRepository _reviewRepository;

  Future<void> loadService(String businessId) async {
    emit(const ServiceDetailState(isLoading: true));
    try {
      final result = await _getBusinessDetail.execute(businessId);
      if (result is! Success<BusinessModel>) {
        emit(
          const ServiceDetailState(
            errorMessage: 'This service is unavailable.',
          ),
        );
        return;
      }
      final business = result.value;
      final recordResult = await _recordRecentlyViewed.execute(business.id);
      if (recordResult is Success<void>) _recentlyViewedUpdates.notifyChanged();
      final results = await Future.wait([
        _savedRepository.isSaved(business.id),
        _reviewRepository.getPreviewReviews(business.id),
      ]);
      emit(
        ServiceDetailState(
          business: business,
          isSaved: results[0] as bool,
          reviews: results[1] as List<BusinessReviewModel>,
        ),
      );
    } catch (_) {
      emit(
        const ServiceDetailState(errorMessage: 'This service is unavailable.'),
      );
    }
  }

  Future<void> toggleSaved(ServiceListing service) async {
    final wasSaved = state.isSaved;
    emit(
      ServiceDetailState(
        business: state.business,
        isSaved: !wasSaved,
        reviews: state.reviews,
      ),
    );
    await _savedRepository.toggleService(service, wasSaved);
  }
}
