import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PaymentWalletOption extends StatelessWidget {
  const PaymentWalletOption({
    super.key,
    required this.label,
    required this.icon,
  });
  final String label;
  final Widget icon;
  @override
  Widget build(BuildContext context) => Container(
    height: 72,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
        ),
      ],
    ),
  );
}
