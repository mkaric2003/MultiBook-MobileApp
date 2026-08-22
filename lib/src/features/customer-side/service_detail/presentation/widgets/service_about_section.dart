import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:flutter/material.dart';

class ServiceAboutSection extends StatelessWidget {
  const ServiceAboutSection({required this.business, super.key});

  final BusinessModel business;

  @override
  Widget build(BuildContext context) {
    final description = business.shortDescription;
    if (description == null || description.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 28, 22, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.about,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          Text(
            description,
            style: const TextStyle(
              color: AppColors.muted,
              fontSize: 16,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}
