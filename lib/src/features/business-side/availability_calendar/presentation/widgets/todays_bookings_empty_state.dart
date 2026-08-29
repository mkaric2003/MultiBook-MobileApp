import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TodaysBookingsEmptyState extends StatelessWidget {
  const TodaysBookingsEmptyState({super.key});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
    ),
    child: const Column(
      children: [
        Icon(Icons.event_available_outlined, color: AppColors.muted, size: 32),
        SizedBox(height: 10),
        Text(
          'No bookings today',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 4),
        Text(
          'New bookings will appear here.',
          style: TextStyle(color: AppColors.muted),
        ),
      ],
    ),
  );
}
