import 'package:aquabook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/data/models/booking_draft_model.dart';

class CustomerDashboardState {
  const CustomerDashboardState({
    this.selectedTab = CustomerHomeTab.stays,
    this.isRecommendedStaysLoading = true,
    this.recommendedStays = const [],
    this.isOtherStaysLoading = false,
    this.otherStays = const [],
    this.hasMoreOtherStays = true,
    this.bookingDraft,
  });

  final CustomerHomeTab selectedTab;
  final bool isRecommendedStaysLoading;
  final List<StayListing> recommendedStays;
  final bool isOtherStaysLoading;
  final List<StayListing> otherStays;
  final bool hasMoreOtherStays;
  final BookingDraftModel? bookingDraft;
}
