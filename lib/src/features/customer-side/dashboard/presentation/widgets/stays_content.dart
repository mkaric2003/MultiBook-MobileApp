import 'package:multibook/src/data/models/booking_draft_model.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_filters.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/continue_booking_card.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/customer_section_title.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/nearby_stays_list.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/other_stays_grid.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/quick_filter_chips.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/recommended_stays_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StaysContent extends HookWidget {
  const StaysContent({
    super.key,
    required this.nearbyStays,
    required this.isNearbyStaysLoading,
    required this.isLoadingMoreNearbyStays,
    required this.hasMoreNearbyStays,
    required this.recommendedStays,
    required this.isRecommendedStaysLoading,
    required this.otherStays,
    required this.isOtherStaysLoading,
    required this.hasMoreOtherStays,
    required this.isFiltering,
    required this.stayFilters,
    required this.onLoadMoreStays,
    required this.onLoadMoreNearbyStays,
    required this.onStayFiltersChanged,
    this.bookingDraft,
  });

  final List<StayListing> nearbyStays;
  final bool isNearbyStaysLoading;
  final bool isLoadingMoreNearbyStays;
  final bool hasMoreNearbyStays;
  final List<StayListing> recommendedStays;
  final bool isRecommendedStaysLoading;
  final List<StayListing> otherStays;
  final bool isOtherStaysLoading;
  final bool hasMoreOtherStays;
  final bool isFiltering;
  final StayFilters stayFilters;
  final Future<void> Function() onLoadMoreStays;
  final Future<void> Function() onLoadMoreNearbyStays;
  final Future<void> Function(StayFilters filters) onStayFiltersChanged;
  final BookingDraftModel? bookingDraft;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    useEffect(() {
      void loadMoreWhenNeeded() {
        if (!scrollController.hasClients ||
            (!hasMoreOtherStays && !hasMoreNearbyStays)) {
          return;
        }
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 300) {
          if (hasMoreOtherStays) {
            onLoadMoreStays();
          }
        }
      }

      scrollController.addListener(loadMoreWhenNeeded);
      return () => scrollController.removeListener(loadMoreWhenNeeded);
    }, [scrollController, hasMoreOtherStays, onLoadMoreStays]);

    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 78),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuickFilterChips(
            filters: stayFilters,
            onChanged: onStayFiltersChanged,
          ),
          const SizedBox(height: 28),
          if (isFiltering) ...[
            CustomerSectionTitle(title: context.l10n.searchResults),
            const SizedBox(height: 14),
            OtherStaysGrid(
              stays: otherStays,
              isLoading: isOtherStaysLoading || isRecommendedStaysLoading,
              emptyMessage: context.l10n.noStaysMatchFilters,
            ),
          ] else ...[
            // const PromotionBanner(),
            // const SizedBox(height: 28),
            if (bookingDraft != null) ...[
              CustomerSectionTitle(title: context.l10n.continueBooking),
              const SizedBox(height: 14),
              ContinueBookingCard(draft: bookingDraft!),
              const SizedBox(height: 28),
            ],
            if (isNearbyStaysLoading) ...[
              CustomerSectionTitle(title: context.l10n.popularNearYou),
              const SizedBox(height: 18),
              const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 28),
            ] else if (nearbyStays.isNotEmpty) ...[
              CustomerSectionTitle(title: context.l10n.popularNearYou),
              const SizedBox(height: 14),
              NearbyStaysList(
                stays: nearbyStays,
                isLoadingMore: isLoadingMoreNearbyStays,
                hasMore: hasMoreNearbyStays,
                onLoadMore: onLoadMoreNearbyStays,
              ),
              const SizedBox(height: 28),
            ],
            CustomerSectionTitle(title: context.l10n.recommendedForYou),
            const SizedBox(height: 14),
            RecommendedStaysList(
              stays: recommendedStays,
              isLoading: isRecommendedStaysLoading,
            ),
            const SizedBox(height: 28),
            OtherStaysGrid(stays: otherStays, isLoading: isOtherStaysLoading),
          ],
        ],
      ),
    );
  }
}
