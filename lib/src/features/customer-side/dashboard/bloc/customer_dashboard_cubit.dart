import 'package:aquabook/src/data/data_cursor.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/data/repositories/booking_draft_repository.dart';
import 'package:aquabook/src/features/customer-side/dashboard/bloc/customer_dashboard_state.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CustomerDashboardCubit extends Cubit<CustomerDashboardState> {
  CustomerDashboardCubit(this._businessRepository, this._draftRepository)
    : super(const CustomerDashboardState());

  final BusinessRepository _businessRepository;
  final BookingDraftRepository _draftRepository;
  DataCursor<BusinessModel>? _staysCursor;
  DataCursor<BusinessModel>? _servicesCursor;

  void selectTab(CustomerHomeTab tab) {
    emit(state.copyWith(selectedTab: tab));
    if (tab == CustomerHomeTab.services && state.isPopularServicesLoading) {
      loadPopularServices();
    }
  }

  Future<void> loadDraft() async {
    final draft = await _draftRepository.getDraft();
    emit(state.copyWith(bookingDraft: draft));
  }

  Future<void> loadRecommendedStays() async {
    final recommendedBusinesses = await _businessRepository
        .getRecommendedStays();
    emit(
      state.copyWith(
        isRecommendedStaysLoading: false,
        recommendedStays: recommendedBusinesses
            .map(StayListing.fromBusiness)
            .toList(),
      ),
    );
    await loadMoreStays();
  }

  Future<void> loadMoreStays() async {
    if (state.isOtherStaysLoading || !state.hasMoreOtherStays) {
      return;
    }

    _staysCursor ??= _businessRepository.getStaysCursor();
    emit(state.copyWith(isOtherStaysLoading: true));

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
        state.copyWith(
          isOtherStaysLoading: false,
          otherStays: [...state.otherStays, ...newStays],
          hasMoreOtherStays: !_staysCursor!.isEverythingLoaded,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(isOtherStaysLoading: false, hasMoreOtherStays: false),
      );
    }
  }

  Future<void> loadPopularServices() async {
    final popularBusinesses = await _businessRepository.getPopularServices();
    emit(
      state.copyWith(
        isPopularServicesLoading: false,
        popularServices: popularBusinesses
            .map(ServiceListing.fromBusiness)
            .toList(),
      ),
    );
    await loadMoreServices();
  }

  Future<void> loadMoreServices() async {
    if (state.isOtherServicesLoading || !state.hasMoreOtherServices) {
      return;
    }

    _servicesCursor ??= _businessRepository.getServicesCursor();
    emit(state.copyWith(isOtherServicesLoading: true));

    try {
      final nextPage = await _servicesCursor!.fetchNextPage();
      final popularIds = state.popularServices
          .map((service) => service.id)
          .toSet();
      final newServices = nextPage
          .where(
            (business) =>
                business.isActive && !popularIds.contains(business.id),
          )
          .map(ServiceListing.fromBusiness)
          .toList();
      emit(
        state.copyWith(
          isOtherServicesLoading: false,
          otherServices: [...state.otherServices, ...newServices],
          hasMoreOtherServices: !_servicesCursor!.isEverythingLoaded,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isOtherServicesLoading: false,
          hasMoreOtherServices: false,
        ),
      );
    }
  }
}
