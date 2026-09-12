import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AvailabilityCalendarModeButton extends StatelessWidget {
  const AvailabilityCalendarModeButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Expanded(
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : context.appPalette.muted,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    ),
  );
}
