import 'package:aquabook/src/data/data_cursor.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/data/repositories/booking_draft_repository.dart';
import 'package:aquabook/src/data/repositories/appointment_draft_repository.dart';
import 'package:aquabook/src/data/repositories/stay_search_repository.dart';
import 'package:aquabook/src/data/models/appointment_draft_model.dart';
import 'package:aquabook/src/features/customer-side/dashboard/bloc/customer_dashboard_state.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_filters.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_filters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CustomerDashboardCubit extends Cubit<CustomerDashboardState> {
  CustomerDashboardCubit(
    this._businessRepository,
    this._staySearchRepository,
    this._draftRepository,
    this._appointmentDraftRepository,
  ) : super(const CustomerDashboardState());

  final BusinessRepository _businessRepository;
  final StaySearchRepository _staySearchRepository;
  final BookingDraftRepository _draftRepository;
  final AppointmentDraftRepository _appointmentDraftRepository;
  DataCursor<BusinessModel>? _staysCursor;
  String? _staysNextCursor;
  DataCursor<BusinessModel>? _servicesCursor;

  Future<void> loadStayCities() async {
    final cities = await _businessRepository.getStayCities();
    emit(state.copyWith(stayCities: cities));
  }

  void selectTab(CustomerHomeTab tab) {
    emit(state.copyWith(selectedTab: tab));
    if (tab == CustomerHomeTab.services && state.isPopularServicesLoading) {
      loadPopularServices();
    }
  }

  void applyServiceFilters(ServiceFilters filters) {
    emit(state.copyWith(serviceFilters: filters));
  }

  Future<void> loadDraft() async {
    final draft = await _draftRepository.getDraft();
    emit(state.copyWith(bookingDraft: draft));
  }

  Future<void> loadAppointmentDraft() async {
    final draft = await _appointmentDraftRepository.getDraft();
    emit(state.copyWith(appointmentDraft: draft));
  }

  Future<BusinessModel?> getAppointmentDraftBusiness(
    AppointmentDraftModel draft,
  ) => _businessRepository.getBusiness(businessId: draft.businessId);

  Future<void> loadRecommendedStays() async {
    if (!state.stayFilters.hasActiveFilters) {
      await _loadDefaultStays();
      return;
    }

    try {
      final page = await _staySearchRepository.search(
        filters: state.stayFilters,
      );
      _staysNextCursor = page.nextCursor;
      final listings = page.stays.map(StayListing.fromBusiness).toList();
      final isFiltering = state.stayFilters.hasActiveFilters;
      emit(
        state.copyWith(
          isRecommendedStaysLoading: false,
          isOtherStaysLoading: false,
          recommendedStays: isFiltering ? const [] : listings.take(3).toList(),
          otherStays: isFiltering ? listings : listings.skip(3).toList(),
          hasMoreOtherStays: _staysNextCursor != null,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isRecommendedStaysLoading: false,
          isOtherStaysLoading: false,
          hasMoreOtherStays: false,
        ),
      );
    }
  }

  Future<void> loadMoreStays() async {
    if (state.isOtherStaysLoading || !state.hasMoreOtherStays) {
      return;
    }

    if (!state.stayFilters.hasActiveFilters) {
      await _loadMoreDefaultStays();
      return;
    }

    emit(state.copyWith(isOtherStaysLoading: true));

    try {
      final page = await _staySearchRepository.search(
        filters: state.stayFilters,
        cursor: _staysNextCursor,
      );
      _staysNextCursor = page.nextCursor;
      final newStays = page.stays.map(StayListing.fromBusiness).toList();
      emit(
        state.copyWith(
          isOtherStaysLoading: false,
          otherStays: [...state.otherStays, ...newStays],
          hasMoreOtherStays: _staysNextCursor != null,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(isOtherStaysLoading: false, hasMoreOtherStays: false),
      );
    }
  }

  Future<void> applyStayFilters(StayFilters filters) async {
    _staysCursor = null;
    _staysNextCursor = null;
    emit(
      state.copyWith(
        stayFilters: filters,
        isRecommendedStaysLoading: true,
        recommendedStays: const [],
        otherStays: const [],
        hasMoreOtherStays: true,
      ),
    );
    await loadRecommendedStays();
  }

  Future<void> _loadDefaultStays() async {
    try {
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
      await _loadMoreDefaultStays();
    } catch (_) {
      emit(
        state.copyWith(
          isRecommendedStaysLoading: false,
          isOtherStaysLoading: false,
          hasMoreOtherStays: false,
        ),
      );
    }
  }

  Future<void> _loadMoreDefaultStays() async {
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
