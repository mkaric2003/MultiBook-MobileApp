import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/features/business-side/promotions/domain/models/promotion_model.dart';
import 'package:aquabook/src/features/customer-side/appointment_payment/domain/models/appointment_payment_arguments.dart';
import 'package:aquabook/src/features/customer-side/appointment_payment/presentation/widgets/appointment_payment_price_row.dart';
import 'package:flutter/material.dart';

class AppointmentPaymentPriceBreakdown extends StatelessWidget {
  const AppointmentPaymentPriceBreakdown({
    required this.arguments,
    this.promotion,
    super.key,
  });

  final AppointmentPaymentArguments arguments;
  final PromotionModel? promotion;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: AppColors.surfaceHighlight),
    ),
    child: Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            context.l10n.priceBreakdown,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
        ),
        const SizedBox(height: 18),
        AppointmentPaymentPriceRow(
          label: context.l10n.serviceCost,
          value: arguments.discountedServiceCost(promotion),
          originalValue: arguments.discount(promotion) > 0
              ? arguments.serviceCost
              : null,
        ),
        if (arguments.discount(promotion) > 0) ...[
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              context.l10n.discountApplied,
              style: const TextStyle(
                color: AppColors.success,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
        const SizedBox(height: 12),
        AppointmentPaymentPriceRow(
          label: context.l10n.serviceFee,
          value: arguments.serviceFeeWithPromotion(promotion),
        ),
        const SizedBox(height: 12),
        AppointmentPaymentPriceRow(
          label: context.l10n.taxes,
          value: arguments.taxesWithPromotion(promotion),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Divider(color: AppColors.surfaceHighlight),
        ),
        AppointmentPaymentPriceRow(
          label: context.l10n.total,
          value: arguments.totalWithPromotion(promotion),
          emphasized: true,
        ),
      ],
    ),
  );
}
