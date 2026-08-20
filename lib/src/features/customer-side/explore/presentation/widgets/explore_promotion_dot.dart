import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ExplorePromotionDot extends StatelessWidget {
  const ExplorePromotionDot({super.key, this.isActive = false});

  final bool isActive;

  @override
  Widget build(BuildContext context) => Container(
    width: 9,
    height: 9,
    margin: const EdgeInsets.symmetric(horizontal: 3),
    decoration: BoxDecoration(
      color: isActive
          ? AppColors.white
          : AppColors.white.withValues(alpha: 0.55),
      shape: BoxShape.circle,
    ),
  );
}
