import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StayBookingField extends StatelessWidget {
  const StayBookingField({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
        color: AppColors.background,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.muted, fontSize: 13),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
