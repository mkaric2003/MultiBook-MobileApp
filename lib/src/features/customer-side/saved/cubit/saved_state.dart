import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';

class SavedState {
  const SavedState({
    this.stays = const [],
    this.isLoading = false,
    this.removingId,
  });
  final List<StayListing> stays;
  final bool isLoading;
  final String? removingId;
}
