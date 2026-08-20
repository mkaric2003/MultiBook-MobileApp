import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DashboardMetricCard extends StatelessWidget {
  const DashboardMetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.iconBackgroundColor,
    this.valueColor = AppColors.white,
    this.suffix,
    this.iconColor = AppColors.primary,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color iconBackgroundColor;
  final Color valueColor;
  final Widget? suffix;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: AppColors.muted, fontSize: 14),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        color: valueColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (suffix != null) ...[const SizedBox(width: 8), suffix!],
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
        ],
      ),
    );
  }
}
