import 'package:aquabook/src/data/models/booking_model.dart';
import 'package:aquabook/src/features/customer-side/bookings/presentation/widgets/customer_booking_card.dart';
import 'package:flutter/material.dart';

class CustomerBookingsSection extends StatelessWidget {
  const CustomerBookingsSection({
    super.key,
    required this.title,
    required this.bookings,
    required this.onBookingUpdated,
  });

  final String title;
  final List<BookingModel> bookings;
  final ValueChanged<BookingModel> onBookingUpdated;

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 18),
        for (final booking in bookings) ...[
          CustomerBookingCard(
            booking: booking,
            onBookingUpdated: onBookingUpdated,
          ),
          const SizedBox(height: 18),
        ],
      ],
    );
  }
}
