import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/domain/use_cases/customer_discovery/get_popular_nearby_businesses_use_case.dart';
import 'package:multibook/src/domain/use_cases/customer_discovery/get_discovery_cities_use_case.dart';
import 'package:multibook/src/domain/use_cases/customer_discovery/get_featured_collections_use_case.dart';
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:multibook/src/features/customer-side/explore/cubit/explore_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit(
    this._userRepository,
    this._getDiscoveryCities,
    this._getFeaturedCollections,
    this._getPopularNearbyBusinesses,
  ) : super(const ExploreState());

  final UserProfileUseCase _userRepository;
  final GetDiscoveryCitiesUseCase _getDiscoveryCities;
  final GetFeaturedCollectionsUseCase _getFeaturedCollections;
  final GetPopularNearbyBusinessesUseCase _getPopularNearbyBusinesses;
  int _trendingServicesOffset = 0;
  String _trendingServicesCity = '';
  static const _trendingServicesPageSize = 10;

  Future<void> load() async {
    final user = await _userRepository.getCurrentUser();
    final citiesResult = await _getDiscoveryCities.execute();
    final collections = await Future.wait([
      _getFeaturedCollections.execute(BusinessType.stays),
      _getFeaturedCollections.execute(BusinessType.services),
    ]);
    final cities = switch (citiesResult) {
      Success(value: final values) => values,
      FailureResult() => const <String>[],
    };
    final currentCity = user?.city?.trim();
    final allCities = {
      ...cities,
      if (currentCity?.isNotEmpty ?? false) currentCity!,
    }.toList()..sort();
    emit(
      ExploreState(
        isLoading: false,
        selectedCity: currentCity?.isNotEmpty ?? false ? currentCity! : null,
        cities: allCities,
        stayCollections: switch (collections[0]) {
          Success(value: final values) => values,
          FailureResult() => const [],
        },
        serviceCollections: switch (collections[1]) {
          Success(value: final values) => values,
          FailureResult() => const [],
        },
      ),
    );
    await loadTrendingServices(city: currentCity);
  }

  Future<void> selectCity(String? city) async {
    final trimmedCity = city?.trim() ?? '';
    final cities = {
      ...state.cities,
      if (trimmedCity.isNotEmpty) trimmedCity,
    }.toList()..sort();
    emit(
      state.copyWith(
        selectedCity: trimmedCity,
        clearSelectedCity: trimmedCity.isEmpty,
        cities: cities,
      ),
    );
    await loadTrendingServices(city: trimmedCity);
  }

  Future<void> loadTrendingServices({String? city}) async {
    final selectedCity = city?.trim() ?? state.selectedCity?.trim() ?? '';
    if (selectedCity.isEmpty) {
      _trendingServicesOffset = 0;
      _trendingServicesCity = '';
      emit(
        state.copyWith(
          trendingServices: const [],
          isTrendingServicesLoading: false,
          isLoadingMoreTrendingServices: false,
          hasMoreTrendingServices: false,
        ),
      );
      return;
    }

    _trendingServicesOffset = 0;
    _trendingServicesCity = selectedCity;
    emit(
      state.copyWith(
        trendingServices: const [],
        isTrendingServicesLoading: true,
        isLoadingMoreTrendingServices: false,
        hasMoreTrendingServices: true,
      ),
    );
    await loadMoreTrendingServices(isInitialLoad: true);
  }

  Future<void> loadMoreTrendingServices({bool isInitialLoad = false}) async {
    if (_trendingServicesCity.isEmpty ||
        (!isInitialLoad &&
            (state.isLoadingMoreTrendingServices ||
                !state.hasMoreTrendingServices))) {
      return;
    }

    emit(
      state.copyWith(
        isTrendingServicesLoading: isInitialLoad,
        isLoadingMoreTrendingServices: !isInitialLoad,
      ),
    );
    try {
      final result = await _getPopularNearbyBusinesses.execute(
        type: BusinessType.services,
        city: _trendingServicesCity,
        offset: _trendingServicesOffset,
        limit: _trendingServicesPageSize,
      );
      if (result case FailureResult()) {
        throw result.failure;
      }
      final page = (result as Success<List<BusinessModel>>).value;
      final knownIds = state.trendingServices
          .map((service) => service.id)
          .toSet();
      final newServices = page
          .where((business) => business.isActive && knownIds.add(business.id))
          .map(ServiceListing.fromBusiness)
          .toList();
      emit(
        state.copyWith(
          trendingServices: [...state.trendingServices, ...newServices],
          isTrendingServicesLoading: false,
          isLoadingMoreTrendingServices: false,
          hasMoreTrendingServices: page.length == _trendingServicesPageSize,
        ),
      );
      _trendingServicesOffset += page.length;
    } catch (_) {
      emit(
        state.copyWith(
          isTrendingServicesLoading: false,
          isLoadingMoreTrendingServices: false,
          hasMoreTrendingServices: false,
        ),
      );
    }
  }
}
