import 'package:aquabook/src/data/enums/booking_status.dart';
import 'package:aquabook/src/data/models/booking_model.dart';
import 'package:aquabook/src/features/customer-side/bookings/domain/enums/customer_booking_type.dart';

class CustomerBookingsState {
  const CustomerBookingsState({
    this.selectedType = CustomerBookingType.stays,
    this.bookings = const [],
    this.isLoading = true,
    this.isLoadingMore = false,
    this.hasReachedEnd = false,
    this.errorMessage,
  });

  final List<BookingModel> bookings;
  final CustomerBookingType selectedType;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasReachedEnd;
  final String? errorMessage;

  List<BookingModel> get upcomingBookings {
    final today = DateTime.now();
    return bookings
        .where(
          (booking) =>
              !booking.checkOut.isBefore(
                DateTime(today.year, today.month, today.day),
              ) &&
              booking.status != BookingStatus.cancelled &&
              booking.status != BookingStatus.declined &&
              booking.status != BookingStatus.completed,
        )
        .toList()
      ..sort((first, second) => first.checkIn.compareTo(second.checkIn));
  }

  List<BookingModel> get pastBookings {
    final upcomingIds = upcomingBookings.map((booking) => booking.id).toSet();
    return bookings
        .where((booking) => !upcomingIds.contains(booking.id))
        .toList()
      ..sort((first, second) => second.checkIn.compareTo(first.checkIn));
  }
}
