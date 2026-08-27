import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HelpCenterEmptyState extends StatelessWidget {
  const HelpCenterEmptyState({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 36),
    child: Column(
      children: [
        const Icon(Icons.search_off_outlined, size: 40, color: AppColors.muted),
        const SizedBox(height: 12),
        Text(
          context.l10n.helpCenterNoResultsTitle,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(
          context.l10n.helpCenterNoResultsBody,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.muted, fontSize: 14),
        ),
      ],
    ),
  );
}
