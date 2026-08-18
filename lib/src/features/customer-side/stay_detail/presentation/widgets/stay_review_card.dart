import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StayReviewCard extends StatelessWidget {
  const StayReviewCard({super.key, required this.name, required this.review});

  final String name;
  final String review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 5),
          const Text('⭐⭐⭐⭐⭐'),
          const SizedBox(height: 10),
          Text(
            review,
            style: const TextStyle(color: AppColors.muted, height: 1.4),
          ),
        ],
      ),
    );
  }
}
