import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/models/booking_model.dart';
import 'package:flutter/material.dart';

class TodaysBookingCard extends StatelessWidget {
  const TodaysBookingCard({super.key, required this.booking});

  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    final guestCount = booking.adults + booking.children + booking.infants;
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: .2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.person_rounded, color: AppColors.primary),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.customerName,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 3),
                Text(
                  '${booking.roomType ?? 'Stay booking'} · $guestCount guests',
                  style: const TextStyle(color: AppColors.muted),
                ),
              ],
            ),
          ),
          const Text(
            'Check-in',
            style: TextStyle(
              color: AppColors.muted,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
