import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EarningsSummaryCard extends StatelessWidget {
  const EarningsSummaryCard({
    required this.title,
    required this.value,
    super.key,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColors.surface,
      border: Border.all(color: AppColors.border),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: AppColors.muted, fontSize: 15),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 31,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: const Color(0xFF3F315E),
            borderRadius: BorderRadius.circular(13),
          ),
          child: const Icon(
            Icons.attach_money,
            color: AppColors.primary,
            size: 30,
          ),
        ),
      ],
    ),
  );
}
