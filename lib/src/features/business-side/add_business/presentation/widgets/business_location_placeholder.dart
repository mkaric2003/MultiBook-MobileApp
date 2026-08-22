import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class BusinessLocationPlaceholder extends StatelessWidget {
  const BusinessLocationPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 178,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_on, color: AppColors.primary, size: 30),
          const SizedBox(height: 10),
          Text(
            context.l10n.tapToPlacePin,
            style: const TextStyle(color: AppColors.muted, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
