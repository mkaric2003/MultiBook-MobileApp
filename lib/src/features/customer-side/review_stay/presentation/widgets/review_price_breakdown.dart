import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/customer-side/booking_details/bloc/booking_details_state.dart';
import 'package:multibook/src/data/models/stay_extra_model.dart';
import 'package:multibook/src/features/business-side/promotions/domain/models/promotion_model.dart';
import 'package:multibook/src/features/business-side/promotions/domain/promotion_price_calculator.dart';
import 'package:multibook/src/features/customer-side/review_stay/presentation/widgets/review_price_row.dart';
import 'package:flutter/material.dart';

class ReviewPriceBreakdown extends StatelessWidget {
  const ReviewPriceBreakdown({
    super.key,
    required this.state,
    required this.pricePerNight,
    required this.extras,
    this.promotion,
  });
  final BookingDetailsState state;
  final int pricePerNight;
  final List<StayExtraModel> extras;
  final PromotionModel? promotion;
  @override
  Widget build(BuildContext context) {
    final room = state.nightCount * pricePerNight;
    final extrasTotal = extras.fold(
      0,
      (sum, extra) =>
          sum + extra.price * (extra.isPerNight ? state.nightCount : 1),
    );
    final discount = PromotionPriceCalculator.discount(
      subtotal: room + extrasTotal,
      promotion: promotion,
      nights: state.nightCount,
    );
    final discountedSubtotal = room + extrasTotal - discount;
    final taxes = (discountedSubtotal * .08).round();
    final total = discountedSubtotal + taxes;
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
          if (discount > 0) ...[
            const SizedBox(height: 12),
            ReviewPriceRow(
              label: context.l10n.promotion,
              value: '-${context.l10n.formatCurrency(discount)}',
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
