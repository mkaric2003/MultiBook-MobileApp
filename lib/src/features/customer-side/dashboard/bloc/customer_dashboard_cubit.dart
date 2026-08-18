import 'package:aquabook/src/data/data_cursor.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/data/repositories/booking_draft_repository.dart';
import 'package:aquabook/src/features/customer-side/dashboard/bloc/customer_dashboard_state.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CustomerDashboardCubit extends Cubit<CustomerDashboardState> {
  CustomerDashboardCubit(this._businessRepository, this._draftRepository)
    : super(const CustomerDashboardState());

  final BusinessRepository _businessRepository;
  final BookingDraftRepository _draftRepository;
  DataCursor<BusinessModel>? _staysCursor;

  void selectTab(CustomerHomeTab tab) {
    emit(
      CustomerDashboardState(
        selectedTab: tab,
        isRecommendedStaysLoading: state.isRecommendedStaysLoading,
        recommendedStays: state.recommendedStays,
        isOtherStaysLoading: state.isOtherStaysLoading,
        otherStays: state.otherStays,
        hasMoreOtherStays: state.hasMoreOtherStays,
        bookingDraft: state.bookingDraft,
      ),
    );
  }

  Future<void> loadDraft() async {
    final draft = await _draftRepository.getDraft();
    emit(
      CustomerDashboardState(
        selectedTab: state.selectedTab,
        isRecommendedStaysLoading: state.isRecommendedStaysLoading,
        recommendedStays: state.recommendedStays,
        isOtherStaysLoading: state.isOtherStaysLoading,
        otherStays: state.otherStays,
        hasMoreOtherStays: state.hasMoreOtherStays,
        bookingDraft: draft,
      ),
    );
  }

  Future<void> loadRecommendedStays() async {
    final recommendedBusinesses = await _businessRepository
        .getRecommendedStays();
    emit(
      CustomerDashboardState(
        selectedTab: state.selectedTab,
        isRecommendedStaysLoading: false,
        recommendedStays: recommendedBusinesses
            .map(StayListing.fromBusiness)
            .toList(),
        isOtherStaysLoading: state.isOtherStaysLoading,
        otherStays: state.otherStays,
        hasMoreOtherStays: state.hasMoreOtherStays,
        bookingDraft: state.bookingDraft,
      ),
    );
    await loadMoreStays();
  }

  Future<void> loadMoreStays() async {
    if (state.isOtherStaysLoading || !state.hasMoreOtherStays) {
      return;
    }

    _staysCursor ??= _businessRepository.getStaysCursor();
    emit(
      CustomerDashboardState(
        selectedTab: state.selectedTab,
        isRecommendedStaysLoading: state.isRecommendedStaysLoading,
        recommendedStays: state.recommendedStays,
        isOtherStaysLoading: true,
        otherStays: state.otherStays,
        hasMoreOtherStays: state.hasMoreOtherStays,
        bookingDraft: state.bookingDraft,
      ),
    );

    try {
      final nextPage = await _staysCursor!.fetchNextPage();
      final recommendedIds = state.recommendedStays
          .map((stay) => stay.id)
          .toSet();
      final newStays = nextPage
          .where(
            (business) =>
                business.isActive && !recommendedIds.contains(business.id),
          )
          .map(StayListing.fromBusiness)
          .toList();
      emit(
        CustomerDashboardState(
          selectedTab: state.selectedTab,
          isRecommendedStaysLoading: state.isRecommendedStaysLoading,
          recommendedStays: state.recommendedStays,
          isOtherStaysLoading: false,
          otherStays: [...state.otherStays, ...newStays],
          hasMoreOtherStays: !_staysCursor!.isEverythingLoaded,
          bookingDraft: state.bookingDraft,
        ),
      );
    } catch (_) {
      emit(
        CustomerDashboardState(
          selectedTab: state.selectedTab,
          isRecommendedStaysLoading: state.isRecommendedStaysLoading,
          recommendedStays: state.recommendedStays,
          isOtherStaysLoading: false,
          otherStays: state.otherStays,
          hasMoreOtherStays: false,
          bookingDraft: state.bookingDraft,
        ),
      );
    }
  }
}
