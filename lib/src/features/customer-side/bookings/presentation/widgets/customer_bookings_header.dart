import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomerBookingsHeader extends StatelessWidget {
  const CustomerBookingsHeader({super.key});

  @override
  Widget build(BuildContext context) => Container(
    height: 86,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    alignment: Alignment.centerLeft,
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: AppColors.surfaceHighlight)),
    ),
    child: const Row(
      children: [
        Expanded(
          child: Text(
            'My bookings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          ),
        ),
        Icon(Icons.calendar_month_outlined, color: AppColors.muted),
      ],
    ),
  );
}
