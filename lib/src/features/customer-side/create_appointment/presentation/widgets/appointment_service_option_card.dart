import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/models/service_offering_model.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class AppointmentServiceOptionCard extends StatelessWidget {
  const AppointmentServiceOptionCard({
    required this.offering,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final ServiceOfferingModel offering;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offering.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    context.l10n.serviceDuration(offering.durationMinutes),
                    style: const TextStyle(color: AppColors.muted),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    context.l10n.formatCurrency(offering.price),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              color: isSelected ? AppColors.primary : AppColors.white,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
