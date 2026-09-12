import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OnboardingPageIndicator extends StatelessWidget {
  const OnboardingPageIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
  });

  final int currentPage;
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        pageCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: currentPage == index ? 26 : 8,
          decoration: BoxDecoration(
            color: currentPage == index
                ? AppColors.primary
                : context.appPalette.border,
            borderRadius: BorderRadius.circular(99),
          ),
        ),
      ),
    );
  }
}
