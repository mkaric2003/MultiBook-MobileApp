import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StayFilterDateField extends StatelessWidget {
  const StayFilterDateField({
    super.key,
    required this.label,
    required this.date,
    required this.onTap,
  });

  final String label;
  final DateTime? date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 82,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.appPalette.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: context.appPalette.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: context.appPalette.muted)),
              const SizedBox(height: 7),
              Text(
                date == null
                    ? 'Select date'
                    : MaterialLocalizations.of(context).formatMediumDate(date!),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
