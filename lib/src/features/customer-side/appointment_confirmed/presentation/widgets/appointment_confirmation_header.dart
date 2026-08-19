import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppointmentConfirmationHeader extends StatelessWidget {
  const AppointmentConfirmationHeader({super.key});

  @override
  Widget build(BuildContext context) => const Column(
    children: [
      CircleAvatar(
        radius: 48,
        backgroundColor: AppColors.success,
        child: Icon(Icons.check_rounded, color: Colors.white, size: 58),
      ),
      SizedBox(height: 24),
      Text(
        'Appointment Confirmed!',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
      ),
      SizedBox(height: 8),
      Text(
        'Your appointment has been successfully confirmed',
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.muted, fontSize: 16),
      ),
    ],
  );
}
