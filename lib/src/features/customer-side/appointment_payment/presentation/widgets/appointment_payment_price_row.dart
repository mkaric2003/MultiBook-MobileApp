import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppointmentPaymentPriceRow extends StatelessWidget {
  const AppointmentPaymentPriceRow({
    required this.label,
    required this.value,
    this.emphasized = false,
    super.key,
  });

  final String label;
  final num value;
  final bool emphasized;

  String get _formattedValue =>
      value is int ? value.toString() : (value as double).toStringAsFixed(2);

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
      Text(
        '\$$_formattedValue',
        style: TextStyle(
          fontSize: emphasized ? 18 : 16,
          fontWeight: FontWeight.w800,
        ),
      ),
    ],
  );
}
