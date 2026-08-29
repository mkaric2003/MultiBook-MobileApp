import 'package:multibook/src/data/data_cursor.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/data/repositories/business_repository.dart';
import 'package:multibook/src/data/repositories/user_repository.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:multibook/src/features/customer-side/explore/cubit/explore_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit(this._userRepository, this._businessRepository)
    : super(const ExploreState());

  final UserRepository _userRepository;
  final BusinessRepository _businessRepository;
  DataCursor<BusinessModel>? _trendingServicesCursor;

  Future<void> load() async {
    final user = await _userRepository.getCurrentUser();
    final cities = await _businessRepository.getStayCities();
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
      _trendingServicesCursor = null;
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

    _trendingServicesCursor = _businessRepository.getServicesNearCityCursor(
      city: selectedCity,
    );
    emit(
      state.copyWith(
        trendingServices: const [],
        isTrendingServicesLoading: true,
        isLoadingMoreTrendingServices: false,
        hasMoreTrendingServices: _trendingServicesCursor != null,
      ),
    );
    await loadMoreTrendingServices(isInitialLoad: true);
  }

  Future<void> loadMoreTrendingServices({bool isInitialLoad = false}) async {
    final cursor = _trendingServicesCursor;
    if (cursor == null ||
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
      final page = await cursor.fetchNextPage();
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
          hasMoreTrendingServices: !cursor.isEverythingLoaded,
        ),
      );
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
