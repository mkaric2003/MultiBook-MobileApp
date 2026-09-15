import 'package:multibook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:multibook/src/data/models/booking_draft_model.dart';
import 'package:multibook/src/data/models/appointment_draft_model.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_filters.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_filters.dart';

class CustomerDashboardState {
  const CustomerDashboardState({
    this.selectedTab = CustomerHomeTab.stays,
    this.isRecommendedStaysLoading = true,
    this.isNearbyStaysLoading = true,
    this.isLoadingMoreNearbyStays = false,
    this.nearbyStays = const [],
    this.hasMoreNearbyStays = true,
    this.recommendedStays = const [],
    this.isOtherStaysLoading = false,
    this.otherStays = const [],
    this.hasMoreOtherStays = true,
    this.stayFilters = const StayFilters(),
    this.stayCities = const [],
    this.serviceFilters = const ServiceFilters(),
    this.isPopularServicesLoading = true,
    this.isLoadingMorePopularServices = false,
    this.popularServices = const [],
    this.hasMorePopularServices = true,
    this.isOtherServicesLoading = false,
    this.otherServices = const [],
    this.hasMoreOtherServices = true,
    this.bookingDraft,
    this.appointmentDraft,
  });

  final CustomerHomeTab selectedTab;
  final bool isRecommendedStaysLoading;
  final bool isNearbyStaysLoading;
  final bool isLoadingMoreNearbyStays;
  final List<StayListing> nearbyStays;
  final bool hasMoreNearbyStays;
  final List<StayListing> recommendedStays;
  final bool isOtherStaysLoading;
  final List<StayListing> otherStays;
  final bool hasMoreOtherStays;
  final StayFilters stayFilters;
  final List<String> stayCities;
  final ServiceFilters serviceFilters;
  final bool isPopularServicesLoading;
  final bool isLoadingMorePopularServices;
  final List<ServiceListing> popularServices;
  final bool hasMorePopularServices;
  final bool isOtherServicesLoading;
  final List<ServiceListing> otherServices;
  final bool hasMoreOtherServices;
  final BookingDraftModel? bookingDraft;
  final AppointmentDraftModel? appointmentDraft;

  CustomerDashboardState copyWith({
    CustomerHomeTab? selectedTab,
    bool? isRecommendedStaysLoading,
    bool? isNearbyStaysLoading,
    bool? isLoadingMoreNearbyStays,
    List<StayListing>? nearbyStays,
    bool? hasMoreNearbyStays,
    List<StayListing>? recommendedStays,
    bool? isOtherStaysLoading,
    List<StayListing>? otherStays,
    bool? hasMoreOtherStays,
    StayFilters? stayFilters,
    List<String>? stayCities,
    ServiceFilters? serviceFilters,
    bool? isPopularServicesLoading,
    bool? isLoadingMorePopularServices,
    List<ServiceListing>? popularServices,
    bool? hasMorePopularServices,
    bool? isOtherServicesLoading,
    List<ServiceListing>? otherServices,
    bool? hasMoreOtherServices,
    Object? bookingDraft = _unset,
    Object? appointmentDraft = _unset,
  }) {
    return CustomerDashboardState(
      selectedTab: selectedTab ?? this.selectedTab,
      isRecommendedStaysLoading:
          isRecommendedStaysLoading ?? this.isRecommendedStaysLoading,
      isNearbyStaysLoading: isNearbyStaysLoading ?? this.isNearbyStaysLoading,
      isLoadingMoreNearbyStays:
          isLoadingMoreNearbyStays ?? this.isLoadingMoreNearbyStays,
      nearbyStays: nearbyStays ?? this.nearbyStays,
      hasMoreNearbyStays: hasMoreNearbyStays ?? this.hasMoreNearbyStays,
      recommendedStays: recommendedStays ?? this.recommendedStays,
      isOtherStaysLoading: isOtherStaysLoading ?? this.isOtherStaysLoading,
      otherStays: otherStays ?? this.otherStays,
      hasMoreOtherStays: hasMoreOtherStays ?? this.hasMoreOtherStays,
      stayFilters: stayFilters ?? this.stayFilters,
      stayCities: stayCities ?? this.stayCities,
      serviceFilters: serviceFilters ?? this.serviceFilters,
      isPopularServicesLoading:
          isPopularServicesLoading ?? this.isPopularServicesLoading,
      isLoadingMorePopularServices:
          isLoadingMorePopularServices ?? this.isLoadingMorePopularServices,
      popularServices: popularServices ?? this.popularServices,
      hasMorePopularServices:
          hasMorePopularServices ?? this.hasMorePopularServices,
      isOtherServicesLoading:
          isOtherServicesLoading ?? this.isOtherServicesLoading,
      otherServices: otherServices ?? this.otherServices,
      hasMoreOtherServices: hasMoreOtherServices ?? this.hasMoreOtherServices,
      bookingDraft: identical(bookingDraft, _unset)
          ? this.bookingDraft
          : bookingDraft as BookingDraftModel?,
      appointmentDraft: identical(appointmentDraft, _unset)
          ? this.appointmentDraft
          : appointmentDraft as AppointmentDraftModel?,
    );
  }

  static const _unset = Object();
}
