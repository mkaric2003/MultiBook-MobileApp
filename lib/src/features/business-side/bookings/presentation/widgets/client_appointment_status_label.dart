import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ClientAppointmentStatusLabel extends StatelessWidget {
  const ClientAppointmentStatusLabel({required this.status, super.key});

  final String status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      'confirmed' => AppColors.success,
      'cancelled' => Colors.redAccent,
      'declined' => const Color(0xFFF59E0B),
      'completed' => AppColors.iconMuted,
      _ => AppColors.primary,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status[0].toUpperCase() + status.substring(1),
        style: TextStyle(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}
