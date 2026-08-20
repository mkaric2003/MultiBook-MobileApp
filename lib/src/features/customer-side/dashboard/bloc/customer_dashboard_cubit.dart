import 'dart:async';

import 'package:aquabook/src/data/data_cursor.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/data/repositories/booking_draft_repository.dart';
import 'package:aquabook/src/data/repositories/appointment_draft_repository.dart';
import 'package:aquabook/src/data/repositories/stay_search_repository.dart';
import 'package:aquabook/src/data/repositories/service_search_repository.dart';
import 'package:aquabook/src/data/repositories/user_location_repository.dart';
import 'package:aquabook/src/data/repositories/user_repository.dart';
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
    this._serviceSearchRepository,
    this._draftRepository,
    this._appointmentDraftRepository,
    this._userRepository,
    this._userLocationRepository,
  ) : super(const CustomerDashboardState());

  final BusinessRepository _businessRepository;
  final StaySearchRepository _staySearchRepository;
  final ServiceSearchRepository _serviceSearchRepository;
  final BookingDraftRepository _draftRepository;
  final AppointmentDraftRepository _appointmentDraftRepository;
  final UserRepository _userRepository;
  final UserLocationRepository _userLocationRepository;
  StreamSubscription<String>? _locationCitySubscription;
  DataCursor<BusinessModel>? _nearbyStaysCursor;
  DataCursor<BusinessModel>? _staysCursor;
  String? _staysNextCursor;
  DataCursor<BusinessModel>? _servicesCursor;
  String? _servicesNextCursor;

  Future<void> loadStayCities() async {
    final cities = await _businessRepository.getStayCities();
    emit(state.copyWith(stayCities: cities));
  }

  Future<void> observeUserLocation() async {
    await _locationCitySubscription?.cancel();
    _locationCitySubscription = _userLocationRepository.cityUpdates.listen(
      (city) => loadPopularNearbyStays(city: city),
    );
  }

  Future<void> loadPopularNearbyStays({String? city}) async {
    final customerCity = city?.trim().isNotEmpty == true
        ? city!.trim()
        : (await _userRepository.getCurrentUser())?.city?.trim() ?? '';
    if (customerCity.isEmpty) {
      emit(
        state.copyWith(
          isNearbyStaysLoading: false,
          nearbyStays: const [],
          hasMoreNearbyStays: false,
        ),
      );
      return;
    }

    _nearbyStaysCursor = _businessRepository.getStaysNearCityCursor(
      city: customerCity,
    );
    emit(
      state.copyWith(
        isNearbyStaysLoading: true,
        isLoadingMoreNearbyStays: false,
        nearbyStays: const [],
        hasMoreNearbyStays: _nearbyStaysCursor != null,
      ),
    );
    await loadMoreNearbyStays(isInitialLoad: true);
  }

  Future<void> loadMoreNearbyStays({bool isInitialLoad = false}) async {
    final cursor = _nearbyStaysCursor;
    if (cursor == null ||
        (!isInitialLoad &&
            (state.isLoadingMoreNearbyStays || !state.hasMoreNearbyStays))) {
      return;
    }

    emit(
      state.copyWith(
        isNearbyStaysLoading: isInitialLoad,
        isLoadingMoreNearbyStays: !isInitialLoad,
      ),
    );
    try {
      final page = await cursor.fetchNextPage();
      final knownIds = state.nearbyStays.map((stay) => stay.id).toSet();
      final newStays = page
          .where(
            (business) => business.isActive && !knownIds.contains(business.id),
          )
          .map(StayListing.fromBusiness)
          .toList();
      emit(
        state.copyWith(
          isNearbyStaysLoading: false,
          isLoadingMoreNearbyStays: false,
          nearbyStays: [...state.nearbyStays, ...newStays],
          hasMoreNearbyStays: !cursor.isEverythingLoaded,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isNearbyStaysLoading: false,
          isLoadingMoreNearbyStays: false,
          hasMoreNearbyStays: false,
        ),
      );
    }
  }

  void selectTab(CustomerHomeTab tab) {
    emit(state.copyWith(selectedTab: tab));
    if (tab == CustomerHomeTab.services && state.isPopularServicesLoading) {
      loadPopularServices();
    }
  }

  Future<void> applyServiceFilters(ServiceFilters filters) async {
    _servicesCursor = null;
    _servicesNextCursor = null;
    emit(
      state.copyWith(
        serviceFilters: filters,
        isPopularServicesLoading: true,
        popularServices: const [],
        otherServices: const [],
        hasMoreOtherServices: true,
      ),
    );
    await loadPopularServices();
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
    if (state.serviceFilters.hasActiveFilters) {
      await _loadFilteredServices();
      return;
    }
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

    if (state.serviceFilters.hasActiveFilters) {
      await _loadMoreFilteredServices();
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

  Future<void> _loadFilteredServices() async {
    try {
      final page = await _serviceSearchRepository.search(
        filters: state.serviceFilters,
      );
      _servicesNextCursor = page.nextCursor;
      emit(
        state.copyWith(
          isPopularServicesLoading: false,
          isOtherServicesLoading: false,
          popularServices: const [],
          otherServices: page.services
              .map(ServiceListing.fromBusiness)
              .toList(),
          hasMoreOtherServices: _servicesNextCursor != null,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isPopularServicesLoading: false,
          isOtherServicesLoading: false,
          hasMoreOtherServices: false,
        ),
      );
    }
  }

  Future<void> _loadMoreFilteredServices() async {
    emit(state.copyWith(isOtherServicesLoading: true));
    try {
      final page = await _serviceSearchRepository.search(
        filters: state.serviceFilters,
        cursor: _servicesNextCursor,
      );
      _servicesNextCursor = page.nextCursor;
      emit(
        state.copyWith(
          isOtherServicesLoading: false,
          otherServices: [
            ...state.otherServices,
            ...page.services.map(ServiceListing.fromBusiness),
          ],
          hasMoreOtherServices: _servicesNextCursor != null,
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

  @override
  Future<void> close() async {
    await _locationCitySubscription?.cancel();
    return super.close();
  }
}
