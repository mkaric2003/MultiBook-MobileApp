import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ExploreViewAllCategoriesButton extends StatelessWidget {
  const ExploreViewAllCategoriesButton({
    required this.isExpanded,
    required this.onPressed,
    super.key,
  });

  final bool isExpanded;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Center(
    child: TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.grid_view_rounded,
        size: 18,
      ),
      label: Text(
        isExpanded
            ? context.l10n.showFewerCategories
            : context.l10n.viewAllCategories,
      ),
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      ),
    ),
  );
}
