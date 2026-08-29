import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';

class ExploreStayResultsState {
  const ExploreStayResultsState({
    this.isLoading = true,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.stays = const [],
  });

  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final List<StayListing> stays;

  ExploreStayResultsState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    List<StayListing>? stays,
  }) => ExploreStayResultsState(
    isLoading: isLoading ?? this.isLoading,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    hasMore: hasMore ?? this.hasMore,
    stays: stays ?? this.stays,
  );
}
