import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppointmentConfirmationInfo extends StatelessWidget {
  const AppointmentConfirmationInfo({
    required this.icon,
    required this.label,
    required this.value,
    this.detail,
    this.originalValue,
    this.iconBackground,
    this.iconColor,
    super.key,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? detail;
  final String? originalValue;
  final Color? iconBackground;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: AppColors.surfaceHighlight,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: iconBackground ?? AppColors.primary.withValues(alpha: .2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor ?? AppColors.primary),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: AppColors.muted, fontSize: 12),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  if (originalValue != null) ...[
                    Text(
                      originalValue!,
                      style: const TextStyle(
                        color: AppColors.muted,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: AppColors.muted,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              if (detail != null) ...[
                const SizedBox(height: 2),
                Text(detail!, style: const TextStyle(color: AppColors.muted)),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}
