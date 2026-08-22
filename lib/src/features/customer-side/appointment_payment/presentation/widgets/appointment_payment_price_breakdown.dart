import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/appointment_payment/domain/models/appointment_payment_arguments.dart';
import 'package:aquabook/src/features/customer-side/appointment_payment/presentation/widgets/appointment_payment_price_row.dart';
import 'package:flutter/material.dart';

class AppointmentPaymentPriceBreakdown extends StatelessWidget {
  const AppointmentPaymentPriceBreakdown({required this.arguments, super.key});

  final AppointmentPaymentArguments arguments;

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
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Price breakdown',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
        ),
        const SizedBox(height: 18),
        AppointmentPaymentPriceRow(
          label: 'Service cost',
          value: arguments.serviceCost,
        ),
        const SizedBox(height: 12),
        AppointmentPaymentPriceRow(
          label: 'Service fee',
          value: arguments.serviceFee,
        ),
        const SizedBox(height: 12),
        AppointmentPaymentPriceRow(label: 'Taxes', value: arguments.taxes),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Divider(color: AppColors.surfaceHighlight),
        ),
        AppointmentPaymentPriceRow(
          label: 'Total',
          value: arguments.total,
          emphasized: true,
        ),
      ],
    ),
  );
}
