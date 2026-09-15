import 'package:multibook/src/data/enums/booking_status.dart';

enum ClientBookingFilter { all, confirmed, declined, cancelled, completed }

extension ClientBookingFilterLabel on ClientBookingFilter {
  String get label => switch (this) {
    ClientBookingFilter.all => 'All',
    ClientBookingFilter.confirmed => 'Confirmed',
    ClientBookingFilter.declined => 'Declined',
    ClientBookingFilter.cancelled => 'Cancelled',
    ClientBookingFilter.completed => 'Completed',
  };

  BookingStatus? get bookingStatus => switch (this) {
    ClientBookingFilter.all => null,
    ClientBookingFilter.confirmed => BookingStatus.confirmed,
    ClientBookingFilter.declined => BookingStatus.declined,
    ClientBookingFilter.cancelled => BookingStatus.cancelled,
    ClientBookingFilter.completed => BookingStatus.completed,
  };
}
