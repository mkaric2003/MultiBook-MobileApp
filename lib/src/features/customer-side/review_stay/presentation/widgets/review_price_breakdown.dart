import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/booking_details/bloc/booking_details_state.dart';
import 'package:aquabook/src/data/models/stay_extra_model.dart';
import 'package:aquabook/src/features/customer-side/review_stay/presentation/widgets/review_price_row.dart';
import 'package:flutter/material.dart';

class ReviewPriceBreakdown extends StatelessWidget {
  const ReviewPriceBreakdown({
    super.key,
    required this.state,
    required this.pricePerNight,
    required this.extras,
  });
  final BookingDetailsState state;
  final int pricePerNight;
  final List<StayExtraModel> extras;
  @override
  Widget build(BuildContext context) {
    final room = state.nightCount * pricePerNight;
    final extrasTotal = extras.fold(
      0,
      (sum, extra) =>
          sum + extra.price * (extra.isPerNight ? state.nightCount : 1),
    );
    final taxes = ((room + extrasTotal) * .08).round();
    final total = room + extrasTotal + taxes;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.priceBreakdown,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 20),
          ReviewPriceRow(
            label: 'Room (${state.nightCount} nights)',
            value: context.l10n.formatCurrency(room),
          ),
          if (extrasTotal > 0) ...[
            const SizedBox(height: 12),
            ReviewPriceRow(
              label: 'Extras',
              value: context.l10n.formatCurrency(extrasTotal),
            ),
          ],
          const SizedBox(height: 12),
          ReviewPriceRow(
            label: 'Taxes & fees',
            value: context.l10n.formatCurrency(taxes),
          ),
          const Divider(height: 28, color: AppColors.border),
          ReviewPriceRow(
            label: 'Total',
            value: context.l10n.formatCurrency(total),
            bold: true,
          ),
        ],
      ),
    );
  }
}
