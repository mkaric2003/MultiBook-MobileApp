import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/models/service_provider_model.dart';
import 'package:flutter/material.dart';

class AppointmentProviderOptionCard extends StatelessWidget {
  const AppointmentProviderOptionCard({
    required this.provider,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final ServiceProviderModel provider;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(14),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.surfaceHighlight,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: AppColors.surfaceHighlight,
            child: Icon(Icons.person_rounded, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  provider.title ?? 'Service provider',
                  style: const TextStyle(color: AppColors.muted),
                ),
              ],
            ),
          ),
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: isSelected ? AppColors.primary : AppColors.muted,
          ),
        ],
      ),
    ),
  );
}
