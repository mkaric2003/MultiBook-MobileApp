import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppointmentSummaryRow extends StatelessWidget {
  const AppointmentSummaryRow({
    required this.label,
    required this.value,
    this.emphasized = false,
    super.key,
  });

  final String label;
  final String value;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: emphasized
                  ? context.appPalette.foreground
                  : context.appPalette.muted,
              fontSize: emphasized ? 17 : 15,
              fontWeight: emphasized ? FontWeight.w800 : FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: emphasized ? 19 : 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
