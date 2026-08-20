import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';

class RecentlyViewedState {
  const RecentlyViewedState({this.isLoading = true, this.stays = const []});

  final bool isLoading;
  final List<StayListing> stays;
}
