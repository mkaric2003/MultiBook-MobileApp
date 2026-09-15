import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:multibook/src/data/models/featured_collection_model.dart';

class ExploreState {
  const ExploreState({
    this.isLoading = true,
    this.selectedCity,
    this.cities = const [],
    this.trendingServices = const [],
    this.isTrendingServicesLoading = false,
    this.isLoadingMoreTrendingServices = false,
    this.hasMoreTrendingServices = false,
    this.stayCollections = const [],
    this.serviceCollections = const [],
  });

  final bool isLoading;
  final String? selectedCity;
  final List<String> cities;
  final List<ServiceListing> trendingServices;
  final bool isTrendingServicesLoading;
  final bool isLoadingMoreTrendingServices;
  final bool hasMoreTrendingServices;
  final List<FeaturedCollectionModel> stayCollections;
  final List<FeaturedCollectionModel> serviceCollections;

  ExploreState copyWith({
    bool? isLoading,
    String? selectedCity,
    bool clearSelectedCity = false,
    List<String>? cities,
    List<ServiceListing>? trendingServices,
    bool? isTrendingServicesLoading,
    bool? isLoadingMoreTrendingServices,
    bool? hasMoreTrendingServices,
    List<FeaturedCollectionModel>? stayCollections,
    List<FeaturedCollectionModel>? serviceCollections,
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
    stayCollections: stayCollections ?? this.stayCollections,
    serviceCollections: serviceCollections ?? this.serviceCollections,
  );
}
