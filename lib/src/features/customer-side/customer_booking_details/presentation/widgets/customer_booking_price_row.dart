import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class CustomerBookingPriceRow extends StatelessWidget {
  const CustomerBookingPriceRow({
    super.key,
    required this.label,
    required this.value,
    this.highlighted = false,
  });
  final String label;
  final int value;
  final bool highlighted;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          label,
          style: TextStyle(
            color: highlighted ? Colors.white : AppColors.muted,
            fontSize: 17,
            fontWeight: highlighted ? FontWeight.w800 : FontWeight.w500,
          ),
        ),
      ),
      Text(
        context.l10n.formatCurrency(value),
        style: TextStyle(
          color: highlighted ? AppColors.primary : Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w800,
        ),
      ),
    ],
  );
}
