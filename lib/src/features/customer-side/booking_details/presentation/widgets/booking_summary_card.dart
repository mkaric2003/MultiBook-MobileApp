import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/booking_details/bloc/booking_details_state.dart';
import 'package:aquabook/src/features/customer-side/booking_details/presentation/widgets/booking_summary_row.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingSummaryCard extends StatelessWidget {
  const BookingSummaryCard({
    super.key,
    required this.state,
    required this.pricePerNight,
  });
  final BookingDetailsState state;
  final int pricePerNight;

  @override
  Widget build(BuildContext context) {
    final stayTotal = state.nightCount * pricePerNight;
    final serviceFee = (stayTotal * .08).round();
    final taxes = (stayTotal * .06).round();
    final total = stayTotal + serviceFee + taxes;
    final dateFormat = DateFormat('MMM d');
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Booking summary',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 20),
          BookingSummaryRow(
            label: 'Dates',
            value:
                '${dateFormat.format(state.checkIn)}–${dateFormat.format(state.checkOut)}',
          ),
          const SizedBox(height: 14),
          BookingSummaryRow(
            label: 'Guests',
            value: '${state.totalGuests} guests',
          ),
          const Divider(height: 28, color: AppColors.border),
          BookingSummaryRow(
            label: '${state.nightCount} nights',
            value: '\$$pricePerNight × ${state.nightCount}',
          ),
          const SizedBox(height: 11),
          BookingSummaryRow(label: 'Service fee', value: '\$$serviceFee'),
          const SizedBox(height: 11),
          BookingSummaryRow(label: 'Taxes', value: '\$$taxes'),
          const Divider(height: 28, color: AppColors.border),
          BookingSummaryRow(label: 'Total', value: '\$$total', bold: true),
        ],
      ),
    );
  }
}
