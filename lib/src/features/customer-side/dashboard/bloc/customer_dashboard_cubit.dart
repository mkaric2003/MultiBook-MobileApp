import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/data_cursor.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/models/appointment_draft_model.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/data/repositories/appointment_draft_repository.dart';
import 'package:multibook/src/data/repositories/booking_draft_repository.dart';
import 'package:multibook/src/data/repositories/business_repository.dart';
import 'package:multibook/src/data/repositories/service_search_repository.dart';
import 'package:multibook/src/data/repositories/stay_search_repository.dart';
import 'package:multibook/src/data/repositories/user_location_repository.dart';
import 'package:multibook/src/domain/use_cases/customer_discovery/get_popular_nearby_businesses_use_case.dart';
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart';
import 'package:multibook/src/features/customer-side/dashboard/bloc/customer_dashboard_state.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_filters.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_filters.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';

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
    this._getPopularNearbyBusinesses,
  ) : super(const CustomerDashboardState());

  final BusinessRepository _businessRepository;
  final StaySearchRepository _staySearchRepository;
  final ServiceSearchRepository _serviceSearchRepository;
  final BookingDraftRepository _draftRepository;
  final AppointmentDraftRepository _appointmentDraftRepository;
  final UserProfileUseCase _userRepository;
  final UserLocationRepository _userLocationRepository;
  final GetPopularNearbyBusinessesUseCase _getPopularNearbyBusinesses;
  StreamSubscription<String>? _locationCitySubscription;
  int _nearbyStaysOffset = 0;
  int _nearbyServicesOffset = 0;
  String _nearbyStaysCity = '';
  String _nearbyServicesCity = '';
  static const _nearbyPageSize = 10;
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
    _locationCitySubscription = _userLocationRepository.cityUpdates.listen((
      city,
    ) async {
      await loadPopularNearbyStays(city: city);
      await loadPopularServices(city: city);
    });
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

    _nearbyStaysOffset = 0;
    _nearbyStaysCity = customerCity;
    emit(
      state.copyWith(
        isNearbyStaysLoading: true,
        isLoadingMoreNearbyStays: false,
        nearbyStays: const [],
        hasMoreNearbyStays: true,
      ),
    );
    await loadMoreNearbyStays(isInitialLoad: true);
  }

  Future<void> loadMoreNearbyStays({bool isInitialLoad = false}) async {
    if (!isInitialLoad &&
        (state.isLoadingMoreNearbyStays || !state.hasMoreNearbyStays)) {
      return;
    }

    emit(
      state.copyWith(
        isNearbyStaysLoading: isInitialLoad,
        isLoadingMoreNearbyStays: !isInitialLoad,
      ),
    );
    try {
      final result = await _getPopularNearbyBusinesses.execute(
        type: BusinessType.stays,
        city: _nearbyStaysCity,
        offset: _nearbyStaysOffset,
        limit: _nearbyPageSize,
      );
      if (result is FailureResult<List<BusinessModel>>) throw result.failure;
      final page = (result as Success<List<BusinessModel>>).value;
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
          hasMoreNearbyStays: page.length == _nearbyPageSize,
        ),
      );
      _nearbyStaysOffset += page.length;
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
      await _loadRecommendedStays();
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

  Future<void> _loadRecommendedStays() async {
    try {
      final result = await _getPopularNearbyBusinesses.recommendedStays();
      if (result case FailureResult(failure: final failure)) {
        throw failure;
      }
      final recommendedBusinesses =
          (result as Success<List<BusinessModel>>).value;
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

  Future<void> loadPopularServices({String? city}) async {
    if (state.serviceFilters.hasActiveFilters) {
      await _loadFilteredServices();
      return;
    }

    final customerCity = city?.trim().isNotEmpty == true
        ? city!.trim()
        : (await _userRepository.getCurrentUser())?.city?.trim() ?? '';
    if (customerCity.isEmpty) {
      emit(
        state.copyWith(
          isPopularServicesLoading: false,
          popularServices: const [],
          hasMorePopularServices: false,
        ),
      );
      return;
    }

    _nearbyServicesOffset = 0;
    _nearbyServicesCity = customerCity;
    emit(
      state.copyWith(
        isPopularServicesLoading: true,
        isLoadingMorePopularServices: false,
        popularServices: const [],
        hasMorePopularServices: true,
      ),
    );
    await loadMoreServices();
    await loadMorePopularServices(isInitialLoad: true);
  }

  Future<void> loadMorePopularServices({bool isInitialLoad = false}) async {
    if (!isInitialLoad &&
        (state.isLoadingMorePopularServices || !state.hasMorePopularServices)) {
      return;
    }

    emit(
      state.copyWith(
        isPopularServicesLoading: isInitialLoad,
        isLoadingMorePopularServices: !isInitialLoad,
      ),
    );
    try {
      final result = await _getPopularNearbyBusinesses.execute(
        type: BusinessType.services,
        city: _nearbyServicesCity,
        offset: _nearbyServicesOffset,
        limit: _nearbyPageSize,
      );
      if (result is FailureResult<List<BusinessModel>>) throw result.failure;
      final page = (result as Success<List<BusinessModel>>).value;
      final knownIds = state.popularServices
          .map((service) => service.id)
          .toSet();
      final services = page
          .where((business) => business.isActive && knownIds.add(business.id))
          .map(ServiceListing.fromBusiness)
          .toList();
      emit(
        state.copyWith(
          isPopularServicesLoading: false,
          isLoadingMorePopularServices: false,
          popularServices: [...state.popularServices, ...services],
          hasMorePopularServices: page.length == _nearbyPageSize,
        ),
      );
      _nearbyServicesOffset += page.length;
    } catch (_) {
      emit(
        state.copyWith(
          isPopularServicesLoading: false,
          isLoadingMorePopularServices: false,
          hasMorePopularServices: false,
        ),
      );
    }
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
