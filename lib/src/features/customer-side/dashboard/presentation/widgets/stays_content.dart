import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/continue_booking_card.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/customer_section_title.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/promotion_banner.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/quick_filter_chips.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/recommended_stays_list.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/stay_listing_card.dart';
import 'package:flutter/material.dart';

class StaysContent extends StatelessWidget {
  const StaysContent({
    super.key,
    required this.nearbyStays,
    required this.recommendedStays,
    required this.isRecommendedStaysLoading,
  });

  final List<StayListing> nearbyStays;
  final List<StayListing> recommendedStays;
  final bool isRecommendedStaysLoading;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const QuickFilterChips(),
          const SizedBox(height: 28),
          const PromotionBanner(),
          const SizedBox(height: 28),
          const CustomerSectionTitle(title: 'Continue booking'),
          const SizedBox(height: 14),
          const ContinueBookingCard(),
          const SizedBox(height: 28),
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
        ],
      ),
    );
  }
}
