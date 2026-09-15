import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DestinationSearchField extends StatelessWidget {
  const DestinationSearchField({
    required this.onTap,
    required this.hintText,
    this.onFilterTap,
    this.hasActiveFilters = false,
    super.key,
  });

  final VoidCallback onTap;
  final VoidCallback? onFilterTap;
  final String hintText;
  final bool hasActiveFilters;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(13),
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: context.appPalette.surface,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: context.appPalette.surfaceHighlight),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                hintText,
                style: TextStyle(
                  color: context.appPalette.muted,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (onFilterTap != null)
              IconButton(
                onPressed: onFilterTap,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  Icons.tune_rounded,
                  color: hasActiveFilters
                      ? AppColors.primary
                      : context.appPalette.muted,
                  size: 22,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
