import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PaymentWalletOption extends StatelessWidget {
  const PaymentWalletOption({
    super.key,
    required this.label,
    required this.icon,
    this.backgroundColor = AppColors.surface,
    this.foregroundColor = Colors.white,
    this.borderColor,
    this.onTap,
    this.isSelected = false,
  });
  final String label;
  final Widget icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final VoidCallback? onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(18),
    child: Container(
      height: 72,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isSelected
              ? AppColors.primary
              : borderColor ?? Colors.transparent,
          width: isSelected ? 2 : 1,
        ),
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
    ),
  );
}
