import 'package:aquabook/src/data/models/booking_model.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/features/business-side/bookings/domain/enums/client_booking_filter.dart';

class ClientBookingsState {
  const ClientBookingsState({
    this.filter = ClientBookingFilter.all,
    this.bookings = const [],
    this.businesses = const [],
    this.selectedBusiness,
    this.isLoading = true,
    this.isLoadingMore = false,
    this.hasReachedEnd = false,
    this.errorMessage,
  });

  final ClientBookingFilter filter;
  final List<BookingModel> bookings;
  final List<BusinessModel> businesses;
  final BusinessModel? selectedBusiness;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasReachedEnd;
  final String? errorMessage;
}
