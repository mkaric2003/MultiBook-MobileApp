import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_listing.dart';

class RecentlyViewedServicesState {
  const RecentlyViewedServicesState({
    this.isLoading = true,
    this.services = const [],
  });

  final bool isLoading;
  final List<ServiceListing> services;
}
