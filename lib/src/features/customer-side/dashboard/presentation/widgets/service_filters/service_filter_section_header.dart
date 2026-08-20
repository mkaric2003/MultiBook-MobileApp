import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ServiceFilterSectionHeader extends StatelessWidget {
  const ServiceFilterSectionHeader({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 22),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
