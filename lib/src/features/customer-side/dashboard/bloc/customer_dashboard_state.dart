import 'package:aquabook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:aquabook/src/data/models/booking_draft_model.dart';
import 'package:aquabook/src/data/models/appointment_draft_model.dart';

class CustomerDashboardState {
  const CustomerDashboardState({
    this.selectedTab = CustomerHomeTab.stays,
    this.isRecommendedStaysLoading = true,
    this.recommendedStays = const [],
    this.isOtherStaysLoading = false,
    this.otherStays = const [],
    this.hasMoreOtherStays = true,
    this.isPopularServicesLoading = true,
    this.popularServices = const [],
    this.isOtherServicesLoading = false,
    this.otherServices = const [],
    this.hasMoreOtherServices = true,
    this.bookingDraft,
    this.appointmentDraft,
  });

  final CustomerHomeTab selectedTab;
  final bool isRecommendedStaysLoading;
  final List<StayListing> recommendedStays;
  final bool isOtherStaysLoading;
  final List<StayListing> otherStays;
  final bool hasMoreOtherStays;
  final bool isPopularServicesLoading;
  final List<ServiceListing> popularServices;
  final bool isOtherServicesLoading;
  final List<ServiceListing> otherServices;
  final bool hasMoreOtherServices;
  final BookingDraftModel? bookingDraft;
  final AppointmentDraftModel? appointmentDraft;

  CustomerDashboardState copyWith({
    CustomerHomeTab? selectedTab,
    bool? isRecommendedStaysLoading,
    List<StayListing>? recommendedStays,
    bool? isOtherStaysLoading,
    List<StayListing>? otherStays,
    bool? hasMoreOtherStays,
    bool? isPopularServicesLoading,
    List<ServiceListing>? popularServices,
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
      recommendedStays: recommendedStays ?? this.recommendedStays,
      isOtherStaysLoading: isOtherStaysLoading ?? this.isOtherStaysLoading,
      otherStays: otherStays ?? this.otherStays,
      hasMoreOtherStays: hasMoreOtherStays ?? this.hasMoreOtherStays,
      isPopularServicesLoading:
          isPopularServicesLoading ?? this.isPopularServicesLoading,
      popularServices: popularServices ?? this.popularServices,
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
