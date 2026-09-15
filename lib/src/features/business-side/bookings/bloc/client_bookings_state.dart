import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/features/business-side/bookings/domain/enums/client_booking_filter.dart';
import 'package:multibook/src/features/business-side/bookings/domain/enums/client_bookings_tab.dart';

class ClientBookingsState {
  const ClientBookingsState({
    this.filter = ClientBookingFilter.all,
    this.bookings = const [],
    this.appointments = const [],
    this.businesses = const [],
    this.selectedBusiness,
    this.tab = ClientBookingsTab.stays,
    this.isLoading = true,
    this.isLoadingMore = false,
    this.hasReachedEnd = false,
    this.errorMessage,
  });

  final ClientBookingFilter filter;
  final List<BookingModel> bookings;
  final List<AppointmentModel> appointments;
  final List<BusinessModel> businesses;
  final BusinessModel? selectedBusiness;
  final ClientBookingsTab tab;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasReachedEnd;
  final String? errorMessage;
}
