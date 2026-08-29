import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/features/customer-side/customer_booking_details/presentation/widgets/customer_booking_price_row.dart';
import 'package:flutter/material.dart';

class CustomerBookingPriceCard extends StatelessWidget {
  const CustomerBookingPriceCard({super.key, required this.booking});
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
          context.l10n.priceBreakdown,
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 20),
        CustomerBookingPriceRow(
          label:
              'Room (${booking.checkOut.difference(booking.checkIn).inDays} nights)',
          value: booking.roomSubtotal,
        ),
        if (booking.discountAmount > 0) ...[
          const SizedBox(height: 14),
          CustomerBookingPriceRow(
            label: context.l10n.promotion,
            value: -booking.discountAmount,
            valueColor: AppColors.success,
          ),
        ],
        const SizedBox(height: 14),
        CustomerBookingPriceRow(
          label: 'Cleaning fee',
          value: booking.cleaningFee,
        ),
        const SizedBox(height: 14),
        CustomerBookingPriceRow(
          label: 'Service fee',
          value: booking.serviceFee,
        ),
        const SizedBox(height: 14),
        CustomerBookingPriceRow(label: 'Taxes', value: booking.taxes),
        const Divider(height: 30, color: AppColors.border),
        CustomerBookingPriceRow(
          label: 'Total paid',
          value: booking.total,
          highlighted: true,
        ),
      ],
    ),
  );
}
