import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:flutter/material.dart';

class StayAboutSection extends StatelessWidget {
  const StayAboutSection({super.key, required this.business});

  final BusinessModel business;

  @override
  Widget build(BuildContext context) {
    final description = business.shortDescription;
    if (description == null || description.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.aboutThisStay,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          Text(
            description,
            style: TextStyle(
              color: context.appPalette.muted,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
