import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BookingDateValue extends StatelessWidget {
  const BookingDateValue({super.key, required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(13),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.muted, fontSize: 13),
        ),
        const SizedBox(height: 7),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
      ],
    ),
  );
}
