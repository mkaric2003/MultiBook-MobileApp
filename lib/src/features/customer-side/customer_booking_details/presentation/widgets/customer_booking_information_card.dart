import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/models/booking_model.dart';
import 'package:aquabook/src/features/customer-side/bookings/presentation/widgets/customer_booking_status_pill.dart';
import 'package:aquabook/src/features/customer-side/customer_booking_details/presentation/widgets/customer_booking_information_row.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerBookingInformationCard extends StatelessWidget {
  const CustomerBookingInformationCard({super.key, required this.booking});
  final BookingModel booking;
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.bookingInformation,
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 20),
        CustomerBookingInformationRow(
          label: 'Dates',
          value:
              '${DateFormat('MMM d, y').format(booking.checkIn)} – ${DateFormat('MMM d, y').format(booking.checkOut)}',
        ),
        const SizedBox(height: 18),
        CustomerBookingInformationRow(
          label: 'Guests',
          value:
              '${booking.adults} adult${booking.adults == 1 ? '' : 's'}${booking.children > 0 ? ', ${booking.children} child${booking.children == 1 ? '' : 'ren'}' : ''}',
        ),
        const SizedBox(height: 18),
        CustomerBookingInformationRow(
          label: 'Room Type',
          value: booking.roomType ?? 'Stay booking',
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Status',
                style: TextStyle(color: AppColors.muted, fontSize: 17),
              ),
            ),
            CustomerBookingStatusPill(status: booking.status),
          ],
        ),
        const SizedBox(height: 18),
        CustomerBookingInformationRow(
          label: 'Confirmation',
          value: booking.confirmationCode,
        ),
      ],
    ),
  );
}
