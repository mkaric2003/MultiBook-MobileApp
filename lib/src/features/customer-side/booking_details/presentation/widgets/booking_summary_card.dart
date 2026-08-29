import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/features/customer-side/booking_details/bloc/booking_details_state.dart';
import 'package:multibook/src/features/customer-side/booking_details/presentation/widgets/booking_summary_row.dart';
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
          Text(
            context.l10n.bookingSummary,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 20),
          BookingSummaryRow(
            label: context.l10n.dates,
            value:
                '${dateFormat.format(state.checkIn)}–${dateFormat.format(state.checkOut)}',
          ),
          const SizedBox(height: 14),
          BookingSummaryRow(
            label: context.l10n.guestSelection,
            value: context.l10n.guests(state.totalGuests),
          ),
          const Divider(height: 28, color: AppColors.border),
          BookingSummaryRow(
            label: context.l10n.nights(state.nightCount),
            value:
                '${context.l10n.formatCurrency(pricePerNight)} × ${state.nightCount}',
          ),
          const SizedBox(height: 11),
          BookingSummaryRow(
            label: context.l10n.serviceFee,
            value: context.l10n.formatCurrency(serviceFee),
          ),
          const SizedBox(height: 11),
          BookingSummaryRow(
            label: context.l10n.taxes,
            value: context.l10n.formatCurrency(taxes),
          ),
          const Divider(height: 28, color: AppColors.border),
          BookingSummaryRow(
            label: context.l10n.total,
            value: context.l10n.formatCurrency(total),
            bold: true,
          ),
        ],
      ),
    );
  }
}
