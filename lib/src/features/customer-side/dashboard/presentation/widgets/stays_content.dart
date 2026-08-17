import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/data/models/booking_draft_model.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/continue_booking_card.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/customer_section_title.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/other_stays_grid.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/promotion_banner.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/quick_filter_chips.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/recommended_stays_list.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/stay_listing_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StaysContent extends HookWidget {
  const StaysContent({
    super.key,
    required this.nearbyStays,
    required this.recommendedStays,
    required this.isRecommendedStaysLoading,
    required this.otherStays,
    required this.isOtherStaysLoading,
    required this.hasMoreOtherStays,
    required this.onLoadMoreStays,
    this.bookingDraft,
  });

  final List<StayListing> nearbyStays;
  final List<StayListing> recommendedStays;
  final bool isRecommendedStaysLoading;
  final List<StayListing> otherStays;
  final bool isOtherStaysLoading;
  final bool hasMoreOtherStays;
  final Future<void> Function() onLoadMoreStays;
  final BookingDraftModel? bookingDraft;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    useEffect(() {
      void loadMoreWhenNeeded() {
        if (!scrollController.hasClients || !hasMoreOtherStays) {
          return;
        }
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 300) {
          onLoadMoreStays();
        }
      }

      scrollController.addListener(loadMoreWhenNeeded);
      return () => scrollController.removeListener(loadMoreWhenNeeded);
    }, [scrollController, hasMoreOtherStays, onLoadMoreStays]);

    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const QuickFilterChips(),
          const SizedBox(height: 28),
          const PromotionBanner(),
          const SizedBox(height: 28),
          if (bookingDraft != null) ...[
            const CustomerSectionTitle(title: 'Continue booking'),
            const SizedBox(height: 14),
            ContinueBookingCard(draft: bookingDraft!),
            const SizedBox(height: 28),
          ],
          const CustomerSectionTitle(title: 'Popular near you'),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: StayListingCard(stay: nearbyStays[0], compact: true),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: StayListingCard(stay: nearbyStays[1], compact: true),
              ),
            ],
          ),
          const SizedBox(height: 28),
          const CustomerSectionTitle(title: 'Recommended for you'),
          const SizedBox(height: 14),
          RecommendedStaysList(
            stays: recommendedStays,
            isLoading: isRecommendedStaysLoading,
          ),
          const SizedBox(height: 28),
          OtherStaysGrid(stays: otherStays, isLoading: isOtherStaysLoading),
        ],
      ),
    );
  }
}
