import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class QuickFilterChips extends StatelessWidget {
  const QuickFilterChips({super.key});

  static const _filters = ['Today', 'Weekend', 'Free cancel', 'Pet friendly'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isSelected = index == 0;
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 17),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.surface,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Text(
              _filters[index],
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.muted,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }
}
