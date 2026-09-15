import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/app.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:multibook/src/features/customer-side/bookings/presentation/widgets/customer_booking_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CustomerBookingCard extends StatelessWidget {
  const CustomerBookingCard({
    super.key,
    required this.booking,
    required this.onBookingUpdated,
  });

  final BookingModel booking;
  final ValueChanged<BookingModel> onBookingUpdated;

  bool get _canBookAgain {
    final now = DateTime.now();
    return booking.checkOut.isBefore(DateTime(now.year, now.month, now.day));
  }

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: context.appPalette.surface,
      border: Border.all(color: context.appPalette.surfaceHighlight),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                booking.businessImageUrl,
                width: 78,
                height: 78,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => SizedBox(
                  width: 78,
                  height: 78,
                  child: ColoredBox(color: context.appPalette.surfaceHighlight),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.businessName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${DateFormat('MMM d').format(booking.checkIn)} – ${DateFormat('MMM d').format(booking.checkOut)}',
                    style: TextStyle(
                      color: context.appPalette.muted,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    [
                      context.l10n.adults(booking.adults),
                      if (booking.children > 0)
                        context.l10n.children(booking.children),
                    ].join(', '),
                    style: TextStyle(
                      color: context.appPalette.muted,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            CustomerBookingStatusPill(status: booking.status),
            const Spacer(),
            InkWell(
              onTap: () async {
                if (_canBookAgain) {
                  await context.push(
                    AppRoutes.STAY_DETAIL,
                    extra: StayListing(
                      id: booking.businessId,
                      name: booking.businessName,
                      location: booking.businessCity,
                      rating: 0,
                      reviewCount: 0,
                      imageUrl: booking.businessImageUrl,
                    ),
                  );
                  return;
                }
                final updatedBooking = await context.push<BookingModel>(
                  AppRoutes.CUSTOMER_BOOKING_DETAILS,
                  extra: booking,
                );
                if (updatedBooking != null) onBookingUpdated(updatedBooking);
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  _canBookAgain
                      ? context.l10n.bookAgain
                      : context.l10n.viewDetails,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
