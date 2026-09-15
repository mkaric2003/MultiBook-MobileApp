import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/features/customer-side/booking_details/bloc/booking_details_state.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
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
        color: context.appPalette.surface,
        border: Border.all(color: context.appPalette.border),
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
                  errorBuilder: (_, _, _) => SizedBox(
                    width: 72,
                    height: 72,
                    child: ColoredBox(
                      color: context.appPalette.surfaceHighlight,
                    ),
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
                      '⭐ ${stay.rating.toStringAsFixed(1)} (${context.l10n.reviews(stay.reviewCount)})',
                      style: TextStyle(color: context.appPalette.muted),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${stay.location} • 0.5 km from center',
                      style: TextStyle(color: context.appPalette.muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(height: 32, color: context.appPalette.border),
          _row(
            context,
            'Check-in',
            '${format.format(booking.checkIn)} • 3:00 PM',
          ),
          const SizedBox(height: 18),
          _row(
            context,
            'Check-out',
            '${format.format(booking.checkOut)} • 11:00 AM',
          ),
          const SizedBox(height: 18),
          _row(
            context,
            'Guests',
            '${booking.adults} Adults • ${booking.children} Children',
          ),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value) => Row(
    children: [
      Expanded(
        child: Text(label, style: TextStyle(color: context.appPalette.muted)),
      ),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w800)),
    ],
  );
}
