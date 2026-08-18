import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RecommendedStaysPageIndicator extends StatelessWidget {
  const RecommendedStaysPageIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: index == currentIndex ? 18 : 7,
          height: 7,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: index == currentIndex ? AppColors.primary : AppColors.border,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
