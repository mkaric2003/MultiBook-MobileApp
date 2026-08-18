import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/booking_status.dart';
import 'package:flutter/material.dart';

class ClientBookingStatusPill extends StatelessWidget {
  const ClientBookingStatusPill({super.key, required this.status});

  final BookingStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      BookingStatus.confirmed => ('Confirmed', const Color(0xFF10B981)),
      BookingStatus.declined => ('Declined', const Color(0xFFFB7185)),
      BookingStatus.cancelled => ('Cancelled', const Color(0xFFFB7185)),
      BookingStatus.completed => ('Completed', AppColors.muted),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .22),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 13,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
