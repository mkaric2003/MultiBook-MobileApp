import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EarningsRangeDateButton extends StatelessWidget {
  const EarningsRangeDateButton({
    required this.label,
    required this.value,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String label;
  final DateTime value;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Expanded(
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: .18)
              : context.appPalette.background,
          border: Border.all(
            color: isSelected ? AppColors.primary : context.appPalette.border,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: context.appPalette.muted, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(DateFormat('dd.MM.yyyy').format(value)),
          ],
        ),
      ),
    ),
  );
}
