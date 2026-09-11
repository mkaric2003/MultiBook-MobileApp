import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class QuickFilterChip extends StatelessWidget {
  const QuickFilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 17),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : context.appPalette.surface,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.white : context.appPalette.muted,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
