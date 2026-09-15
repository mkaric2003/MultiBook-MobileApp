import 'package:multibook/src/data/enums/booking_status.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:intl/intl.dart';

class ClientBookingPreview {
  const ClientBookingPreview({
    required this.customerName,
    required this.avatarUrl,
    required this.roomName,
    required this.dateLabel,
    required this.guestCount,
    required this.status,
    required this.total,
  });
  final String customerName;
  final String avatarUrl;
  final String roomName;
  final String dateLabel;
  final int guestCount;
  final BookingStatus status;
  final int total;

  factory ClientBookingPreview.fromBooking(
    BookingModel booking,
  ) => ClientBookingPreview(
    customerName: booking.customerName,
    avatarUrl: booking.customerAvatarUrl ?? '',
    roomName: booking.roomType ?? 'Stay booking',
    dateLabel:
        '${DateFormat('MMM d, y').format(booking.checkIn)} – ${DateFormat('MMM d, y').format(booking.checkOut)}',
    guestCount: booking.adults + booking.children + booking.infants,
    status: booking.status,
    total: booking.total,
  );
}
