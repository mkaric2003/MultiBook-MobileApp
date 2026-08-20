import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_listing.dart';

class ExploreServiceResultsState {
  const ExploreServiceResultsState({
    this.isLoading = true,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.services = const [],
  });

  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final List<ServiceListing> services;

  ExploreServiceResultsState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    List<ServiceListing>? services,
  }) => ExploreServiceResultsState(
    isLoading: isLoading ?? this.isLoading,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    hasMore: hasMore ?? this.hasMore,
    services: services ?? this.services,
  );
}
