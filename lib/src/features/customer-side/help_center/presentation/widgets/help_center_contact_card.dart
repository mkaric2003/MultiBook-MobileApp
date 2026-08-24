import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class HelpCenterContactCard extends StatelessWidget {
  const HelpCenterContactCard({required this.onContactPressed, super.key});

  final VoidCallback onContactPressed;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.surfaceHighlight),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.support_agent, color: AppColors.primary, size: 28),
        const SizedBox(height: 12),
        Text(
          context.l10n.helpCenterContactTitle,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(
          context.l10n.helpCenterContactBody,
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 14,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        CustomButton(
          buttonName: context.l10n.helpCenterContactButton,
          onPressed: onContactPressed,
        ),
      ],
    ),
  );
}
