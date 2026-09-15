import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppointmentCalendarWeekdayLabel extends StatelessWidget {
  const AppointmentCalendarWeekdayLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(color: context.appPalette.muted, fontSize: 12),
      ),
    );
  }
}
