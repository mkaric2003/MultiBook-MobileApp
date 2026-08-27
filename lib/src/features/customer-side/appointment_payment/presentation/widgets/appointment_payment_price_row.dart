import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class AppointmentPaymentPriceRow extends StatelessWidget {
  const AppointmentPaymentPriceRow({
    required this.label,
    required this.value,
    this.originalValue,
    this.emphasized = false,
    super.key,
  });

  final String label;
  final num value;
  final num? originalValue;
  final bool emphasized;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyle(
          color: emphasized ? Colors.white : AppColors.muted,
          fontWeight: emphasized ? FontWeight.w800 : FontWeight.w500,
          fontSize: emphasized ? 18 : 16,
        ),
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (originalValue != null) ...[
            Text(
              context.l10n.formatCurrency(originalValue!),
              style: const TextStyle(
                color: AppColors.muted,
                decoration: TextDecoration.lineThrough,
                decorationColor: AppColors.muted,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Text(
            context.l10n.formatCurrency(value),
            style: TextStyle(
              fontSize: emphasized ? 18 : 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    ],
  );
}
