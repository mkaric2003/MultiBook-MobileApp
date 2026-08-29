import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/models/service_offering_model.dart';
import 'package:multibook/src/features/business-side/promotions/domain/models/promotion_model.dart';
import 'package:multibook/src/features/business-side/promotions/domain/promotion_price_calculator.dart';
import 'package:multibook/src/features/customer-side/review_appointment/presentation/widgets/appointment_summary_row.dart';
import 'package:flutter/material.dart';

class AppointmentPriceSummary extends StatelessWidget {
  const AppointmentPriceSummary({
    required this.offerings,
    this.promotion,
    super.key,
  });

  final List<ServiceOfferingModel> offerings;
  final PromotionModel? promotion;

  @override
  Widget build(BuildContext context) {
    final basePrice = offerings.fold(
      0,
      (total, offering) => total + offering.price,
    );
    final discount = PromotionPriceCalculator.discount(
      subtotal: basePrice,
      promotion: promotion,
    );
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.surfaceHighlight),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              context.l10n.priceSummary,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(height: 18),
          ...offerings.map(
            (offering) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppointmentSummaryRow(
                label: offering.name,
                value: context.l10n.formatCurrency(offering.price),
              ),
            ),
          ),
          const Divider(color: AppColors.surfaceHighlight),
          const SizedBox(height: 8),
          if (discount > 0) ...[
            AppointmentSummaryRow(
              label: context.l10n.promotion,
              value: '-${context.l10n.formatCurrency(discount)}',
            ),
            const SizedBox(height: 10),
          ],
          AppointmentSummaryRow(
            label: context.l10n.total,
            value: context.l10n.formatCurrency(basePrice - discount),
            emphasized: true,
          ),
        ],
      ),
    );
  }
}
