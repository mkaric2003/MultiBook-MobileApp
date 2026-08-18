import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PaymentWalletOption extends StatelessWidget {
  const PaymentWalletOption({
    super.key,
    required this.label,
    required this.icon,
    this.backgroundColor = AppColors.surface,
    this.foregroundColor = Colors.white,
    this.borderColor,
  });
  final String label;
  final Widget icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) => Container(
    height: 72,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(18),
      border: borderColor == null ? null : Border.all(color: borderColor!),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            color: foregroundColor,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}
