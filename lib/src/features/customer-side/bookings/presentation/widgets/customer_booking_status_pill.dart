import 'package:aquabook/src/data/enums/booking_status.dart';
import 'package:flutter/material.dart';

class CustomerBookingStatusPill extends StatelessWidget {
  const CustomerBookingStatusPill({super.key, required this.status});

  final BookingStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      BookingStatus.confirmed => ('Confirmed', const Color(0xFF22C55E)),
      BookingStatus.declined => ('Declined', const Color(0xFFF59E0B)),
      BookingStatus.cancelled => ('Cancelled', const Color(0xFFEF4444)),
      BookingStatus.completed => ('Completed', const Color(0xFF3B82F6)),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .16),
        border: Border.all(color: color.withValues(alpha: .7)),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
