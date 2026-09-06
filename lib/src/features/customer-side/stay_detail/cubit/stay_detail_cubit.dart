import 'dart:async';

import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/use_cases/customer_discovery/get_business_detail_use_case.dart';
import 'package:multibook/src/data/models/business_review_model.dart';
import 'package:multibook/src/core/services/saved_business_updates_service.dart';
import 'package:multibook/src/domain/use_cases/saved/is_business_saved_use_case.dart';
import 'package:multibook/src/domain/use_cases/saved/save_business_use_case.dart';
import 'package:multibook/src/domain/use_cases/saved/remove_saved_business_use_case.dart';
import 'package:multibook/src/domain/use_cases/recently_viewed/record_recently_viewed_use_case.dart';
import 'package:multibook/src/core/services/recently_viewed_updates_service.dart';
import 'package:multibook/src/domain/use_cases/reviews/get_business_reviews_use_case.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:multibook/src/features/customer-side/stay_detail/cubit/stay_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class StayDetailCubit extends Cubit<StayDetailState> {
  StayDetailCubit(
    this._getBusinessDetail,
    this._isBusinessSaved,
    this._saveBusiness,
    this._removeSavedBusiness,
    this._savedUpdates,
    this._recordRecentlyViewed,
    this._recentlyViewedUpdates,
    this._getBusinessReviews,
  ) : super(const StayDetailState()) {
    _savedSubscription = _savedUpdates.changes.listen((_) => _refreshSaved());
  }

  final GetBusinessDetailUseCase _getBusinessDetail;
  final IsBusinessSavedUseCase _isBusinessSaved;
  final SaveBusinessUseCase _saveBusiness;
  final RemoveSavedBusinessUseCase _removeSavedBusiness;
  final SavedBusinessUpdatesService _savedUpdates;
  late final StreamSubscription<void> _savedSubscription;
  bool _saving = false;
  bool _savedKnown = false;
  int _savedRevision = 0;
  final RecordRecentlyViewedUseCase _recordRecentlyViewed;
  final RecentlyViewedUpdatesService _recentlyViewedUpdates;
  final GetBusinessReviewsUseCase _getBusinessReviews;

  Future<void> loadStay(String businessId) async {
    emit(const StayDetailState(isLoading: true));
    try {
      final result = await _getBusinessDetail.execute(businessId);
      if (isClosed) return;
      if (result is! Success<BusinessModel>) {
        emit(const StayDetailState(errorMessage: 'This stay is unavailable.'));
        return;
      }
      final business = result.value;
      final recordResult = await _recordRecentlyViewed.execute(business.id);
      if (recordResult is Success<void>) _recentlyViewedUpdates.notifyChanged();
      final results = await Future.wait([
        _isBusinessSaved.execute(business.id),
        _getBusinessReviews.execute(business.id, limit: 4),
      ]);
      if (isClosed) return;
      _savedKnown = results[0] is Success<bool>;
      emit(
        StayDetailState(
          business: business,
          isSaved: switch (results[0]) {
            Success<bool>(value: final saved) => saved,
            _ => false,
          },
          reviews: switch (results[1]) {
            Success<List<BusinessReviewModel>>(value: final reviews) => reviews,
            _ => const [],
          },
        ),
      );
    } catch (_) {
      if (isClosed) return;
      emit(const StayDetailState(errorMessage: 'This stay is unavailable.'));
    }
  }

  Future<void> _refreshSaved() async {
    final id = state.business?.id;
    if (id == null || _saving || isClosed) return;
    final revision = ++_savedRevision;
    final result = await _isBusinessSaved.execute(id);
    if (isClosed ||
        _saving ||
        revision != _savedRevision ||
        state.business?.id != id) {
      return;
    }
    if (result case Success<bool>(value: final saved)) {
      _savedKnown = true;
      emit(
        StayDetailState(
          business: state.business,
          isSaved: saved,
          reviews: state.reviews,
        ),
      );
    }
  }

  Future<bool> toggleSaved(StayListing stay) async {
    if (_saving || isClosed) return false;
    if (!_savedKnown) {
      await _refreshSaved();
      if (!_savedKnown || _saving || isClosed) return false;
    }
    _saving = true;
    ++_savedRevision;
    final previous = state;
    emit(
      StayDetailState(
        business: state.business,
        isSaved: !state.isSaved,
        reviews: state.reviews,
      ),
    );
    final result = previous.isSaved
        ? await _removeSavedBusiness.execute(stay.id)
        : await _saveBusiness.execute(stay.id);
    _saving = false;
    if (result is Success<void>) {
      _savedUpdates.notifyChanged();
    } else if (!isClosed) {
      emit(previous);
    }
    return result is Success<void>;
  }

  @override
  Future<void> close() async {
    await _savedSubscription.cancel();
    return super.close();
  }
}
