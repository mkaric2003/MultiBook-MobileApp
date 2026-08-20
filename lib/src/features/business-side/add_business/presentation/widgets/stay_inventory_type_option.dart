import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StayInventoryTypeOption extends StatelessWidget {
  const StayInventoryTypeOption({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(10),
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: TextStyle(
              color: isSelected ? AppColors.white : AppColors.muted,
              fontSize: 11,
            ),
          ),
        ],
      ),
    ),
  );
}
