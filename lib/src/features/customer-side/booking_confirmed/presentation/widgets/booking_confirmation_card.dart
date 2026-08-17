import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/booking_details/bloc/booking_details_state.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingConfirmationCard extends StatelessWidget {
  const BookingConfirmationCard({
    super.key,
    required this.stay,
    required this.booking,
  });
  final StayListing stay;
  final BookingDetailsState booking;
  @override
  Widget build(BuildContext context) {
    final format = DateFormat('MMM d, yyyy');
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  stay.imageUrl,
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const SizedBox(
                    width: 72,
                    height: 72,
                    child: ColoredBox(color: AppColors.surfaceHighlight),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stay.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '⭐ ${stay.rating.toStringAsFixed(1)} (${stay.reviewCount} reviews)',
                      style: const TextStyle(color: AppColors.muted),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${stay.location} • 0.5 km from center',
                      style: const TextStyle(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 32, color: AppColors.border),
          _row('Check-in', '${format.format(booking.checkIn)} • 3:00 PM'),
          const SizedBox(height: 18),
          _row('Check-out', '${format.format(booking.checkOut)} • 11:00 AM'),
          const SizedBox(height: 18),
          _row(
            'Guests',
            '${booking.adults} Adults • ${booking.children} Children',
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) => Row(
    children: [
      Expanded(
        child: Text(label, style: const TextStyle(color: AppColors.muted)),
      ),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w800)),
    ],
  );
}
