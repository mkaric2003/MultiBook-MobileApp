import 'dart:async';

import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/core/services/recently_viewed_updates_service.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/domain/use_cases/recently_viewed/get_recently_viewed_businesses_use_case.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:multibook/src/features/shared/recently_viewed/cubit/recently_viewed_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RecentlyViewedCubit extends Cubit<RecentlyViewedState> {
  RecentlyViewedCubit(this._getRecentlyViewed, this._updates)
    : super(const RecentlyViewedState()) {
    _subscription = _updates.changes.listen((_) => load());
  }

  final GetRecentlyViewedBusinessesUseCase _getRecentlyViewed;
  final RecentlyViewedUpdatesService _updates;
  late final StreamSubscription<void> _subscription;

  Future<void> load() async {
    final result = await _getRecentlyViewed.execute(BusinessType.stays);
    final stays = switch (result) {
      Success(value: final items) =>
        items.map(StayListing.fromBusiness).toList(),
      FailureResult() => const <StayListing>[],
    };
    if (!isClosed) emit(RecentlyViewedState(isLoading: false, stays: stays));
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
