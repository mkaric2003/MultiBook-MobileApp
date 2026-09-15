import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ServiceTimePickerButton extends StatelessWidget {
  const ServiceTimePickerButton({
    required this.label,
    required this.time,
    required this.onTap,
    super.key,
  });

  final String label;
  final TimeOfDay time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: context.appPalette.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.appPalette.surfaceHighlight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: context.appPalette.muted, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              time.format(context),
              style: TextStyle(
                color: context.appPalette.foreground,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
