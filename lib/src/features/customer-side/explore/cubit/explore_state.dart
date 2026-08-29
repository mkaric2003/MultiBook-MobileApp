import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_listing.dart';

class ExploreState {
  const ExploreState({
    this.isLoading = true,
    this.selectedCity,
    this.cities = const [],
    this.trendingServices = const [],
    this.isTrendingServicesLoading = false,
    this.isLoadingMoreTrendingServices = false,
    this.hasMoreTrendingServices = false,
  });

  final bool isLoading;
  final String? selectedCity;
  final List<String> cities;
  final List<ServiceListing> trendingServices;
  final bool isTrendingServicesLoading;
  final bool isLoadingMoreTrendingServices;
  final bool hasMoreTrendingServices;

  ExploreState copyWith({
    bool? isLoading,
    String? selectedCity,
    bool clearSelectedCity = false,
    List<String>? cities,
    List<ServiceListing>? trendingServices,
    bool? isTrendingServicesLoading,
    bool? isLoadingMoreTrendingServices,
    bool? hasMoreTrendingServices,
  }) => ExploreState(
    isLoading: isLoading ?? this.isLoading,
    selectedCity: clearSelectedCity ? null : selectedCity ?? this.selectedCity,
    cities: cities ?? this.cities,
    trendingServices: trendingServices ?? this.trendingServices,
    isTrendingServicesLoading:
        isTrendingServicesLoading ?? this.isTrendingServicesLoading,
    isLoadingMoreTrendingServices:
        isLoadingMoreTrendingServices ?? this.isLoadingMoreTrendingServices,
    hasMoreTrendingServices:
        hasMoreTrendingServices ?? this.hasMoreTrendingServices,
  );
}
