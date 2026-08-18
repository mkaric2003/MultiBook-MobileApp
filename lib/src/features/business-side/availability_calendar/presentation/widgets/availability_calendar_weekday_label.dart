import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AvailabilityCalendarWeekdayLabel extends StatelessWidget {
  const AvailabilityCalendarWeekdayLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: AppColors.muted,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
