import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HelpCenterSearchField extends StatelessWidget {
  const HelpCenterSearchField({required this.onChanged, super.key});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) => TextField(
    onChanged: onChanged,
    style: const TextStyle(fontSize: 15),
    decoration: InputDecoration(
      hintText: context.l10n.helpCenterSearchHint,
      prefixIcon: const Icon(Icons.search, color: AppColors.muted),
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.surfaceHighlight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.surfaceHighlight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
      ),
    ),
  );
}
