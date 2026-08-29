import 'package:multibook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_listing.dart';

class CustomerSearchState {
  const CustomerSearchState({
    this.selectedTab = CustomerHomeTab.stays,
    this.query = '',
    this.isLoading = false,
    this.stays = const [],
    this.services = const [],
  });

  final CustomerHomeTab selectedTab;
  final String query;
  final bool isLoading;
  final List<StayListing> stays;
  final List<ServiceListing> services;
}
