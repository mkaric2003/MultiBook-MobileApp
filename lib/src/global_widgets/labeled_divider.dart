import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LabeledDivider extends StatelessWidget {
  const LabeledDivider({
    super.key,
    this.label = 'or continue with',
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  final String label;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              height: 1,
              thickness: 1,
              color: AppColors.surfaceHighlight,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(color: AppColors.muted, fontSize: 16),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Divider(
              height: 1,
              thickness: 1,
              color: AppColors.surfaceHighlight,
            ),
          ),
        ],
      ),
    );
  }
}
