import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomerContactRow extends StatelessWidget {
  const CustomerContactRow({
    required this.icon,
    required this.value,
    super.key,
  });

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value.isEmpty ? 'Not provided' : value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.muted),
          ),
        ),
      ],
    ),
  );
}
