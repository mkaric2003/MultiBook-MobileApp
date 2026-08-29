import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';

class LanguageOption extends StatelessWidget {
  const LanguageOption({
    required this.flagCode,
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String flagCode;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: .14)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.surfaceHighlight,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            CircleFlag(flagCode, size: 34),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle_rounded, color: AppColors.primary),
          ],
        ),
      ),
    ),
  );
}
