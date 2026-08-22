import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/models/service_offering_model.dart';
import 'package:aquabook/src/features/customer-side/review_appointment/presentation/widgets/appointment_summary_row.dart';
import 'package:flutter/material.dart';

class AppointmentPriceSummary extends StatelessWidget {
  const AppointmentPriceSummary({required this.offerings, super.key});

  final List<ServiceOfferingModel> offerings;

  @override
  Widget build(BuildContext context) {
    final basePrice = offerings.fold(
      0,
      (total, offering) => total + offering.price,
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
                value: '\$${offering.price}',
              ),
            ),
          ),
          const Divider(color: AppColors.surfaceHighlight),
          const SizedBox(height: 8),
          AppointmentSummaryRow(
            label: context.l10n.total,
            value: '\$$basePrice',
            emphasized: true,
          ),
        ],
      ),
    );
  }
}
