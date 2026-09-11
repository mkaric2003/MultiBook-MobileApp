import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/models/stay_extra_model.dart';
import 'package:multibook/src/features/business-side/promotions/domain/models/promotion_model.dart';
import 'package:multibook/src/features/customer-side/payment/domain/models/payment_arguments.dart';
import 'package:flutter/material.dart';

class PaymentPriceBreakdown extends StatelessWidget {
  const PaymentPriceBreakdown({
    super.key,
    required this.arguments,
    required this.pricePerNight,
    this.promotion,
  });
  final PaymentArguments arguments;
  final int pricePerNight;
  final PromotionModel? promotion;
  @override
  Widget build(BuildContext context) {
    final booking = arguments.review.bookingState;
    final room = booking.nightCount * pricePerNight;
    final extras = _extraTotal(arguments.selectedExtras, booking.nightCount);
    final discount = arguments.discount(
      pricePerNight: pricePerNight,
      promotion: promotion,
    );
    final discountedSubtotal = room + extras - discount;
    final cleaning = 2500;
    final service = (discountedSubtotal * .05).round();
    final taxes = ((discountedSubtotal + cleaning + service) * .08).round();
    final total = discountedSubtotal + cleaning + service + taxes;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.appPalette.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.priceBreakdown,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 22),
          _row(
            context,
            'Room (${booking.nightCount} nights)',
            context.l10n.formatCurrency(room),
          ),
          if (extras > 0) ...[
            const SizedBox(height: 12),
            _row(context, 'Extras', context.l10n.formatCurrency(extras)),
          ],
          if (discount > 0) ...[
            const SizedBox(height: 12),
            _row(
              context,
              context.l10n.promotion,
              '-${context.l10n.formatCurrency(discount)}',
              valueColor: AppColors.success,
            ),
          ],
          const SizedBox(height: 12),
          _row(context, 'Cleaning fee', context.l10n.formatCurrency(cleaning)),
          const SizedBox(height: 12),
          _row(context, 'Service fee', context.l10n.formatCurrency(service)),
          const SizedBox(height: 12),
          _row(context, 'Taxes', context.l10n.formatCurrency(taxes)),
          Divider(height: 28, color: context.appPalette.border),
          _row(
            context,
            'Total',
            context.l10n.formatCurrency(total),
            bold: true,
          ),
        ],
      ),
    );
  }

  int total({PromotionModel? promotion}) {
    final b = arguments.review.bookingState;
    final room = b.nightCount * pricePerNight;
    final extras = _extraTotal(arguments.selectedExtras, b.nightCount);
    final discount = arguments.discount(
      pricePerNight: pricePerNight,
      promotion: promotion,
    );
    final discountedSubtotal = room + extras - discount;
    final cleaning = 2500;
    final service = (discountedSubtotal * .05).round();
    return discountedSubtotal +
        cleaning +
        service +
        ((discountedSubtotal + cleaning + service) * .08).round();
  }

  int _extraTotal(List<StayExtraModel> extras, int nights) => extras.fold(
    0,
    (sum, extra) => sum + extra.price * (extra.isPerNight ? nights : 1),
  );
  Widget _row(
    BuildContext context,
    String label,
    String value, {
    bool bold = false,
    Color? valueColor,
  }) => Row(
    children: [
      Expanded(
        child: Text(
          label,
          style: TextStyle(
            color: bold
                ? context.appPalette.foreground
                : context.appPalette.muted,
            fontSize: 16,
            fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
          ),
        ),
      ),
      Text(
        value,
        style: TextStyle(
          fontSize: 16,
          fontWeight: bold ? FontWeight.w800 : FontWeight.w700,
          color: valueColor,
        ),
      ),
    ],
  );
}
