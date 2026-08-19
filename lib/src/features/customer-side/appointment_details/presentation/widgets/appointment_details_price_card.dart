import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/appointment_details/domain/models/appointment_details_arguments.dart';
import 'package:aquabook/src/features/customer-side/appointment_details/domain/utils/appointment_details_formatters.dart';
import 'package:aquabook/src/features/customer-side/appointment_details/presentation/widgets/appointment_details_row.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsPriceCard extends StatelessWidget {
  const AppointmentDetailsPriceCard({required this.arguments, super.key});

  final AppointmentDetailsArguments arguments;

  @override
  Widget build(BuildContext context) {
    final appointment = arguments.appointment;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceHighlight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Price breakdown',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 20),
          AppointmentDetailsRow(
            label: 'Services',
            value: '\$${appointment.serviceCost}',
          ),
          if (appointment.addOnsCost > 0) ...[
            const SizedBox(height: 12),
            AppointmentDetailsRow(
              label: 'Add-ons',
              value: '\$${appointment.addOnsCost}',
            ),
          ],
          const SizedBox(height: 12),
          AppointmentDetailsRow(
            label: 'Service fee',
            value: '\$${appointment.serviceFee.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 12),
          AppointmentDetailsRow(
            label: 'Taxes',
            value: '\$${appointment.taxes.toStringAsFixed(2)}',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(color: AppColors.surfaceHighlight),
          ),
          AppointmentDetailsRow(
            label: 'Total paid',
            value: '\$${appointment.total.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 12),
          AppointmentDetailsRow(
            label: 'Payment method',
            value: AppointmentDetailsFormatters.paymentMethod(
              appointment.paymentMethod,
            ),
          ),
        ],
      ),
    );
  }
}
