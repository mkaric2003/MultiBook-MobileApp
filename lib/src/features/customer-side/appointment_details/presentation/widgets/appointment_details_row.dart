import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsRow extends StatelessWidget {
  const AppointmentDetailsRow({
    required this.label,
    required this.value,
    this.valueColor,
    super.key,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 104,
        child: Text(label, style: const TextStyle(color: AppColors.muted)),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Text(
          value,
          textAlign: TextAlign.end,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.w700, color: valueColor),
        ),
      ),
    ],
  );
}
