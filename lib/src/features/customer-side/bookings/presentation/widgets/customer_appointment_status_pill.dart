import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class CustomerAppointmentStatusPill extends StatelessWidget {
  const CustomerAppointmentStatusPill({required this.status, super.key});

  final String status;

  @override
  Widget build(BuildContext context) {
    final normalized = status.toLowerCase();
    final color = switch (normalized) {
      'confirmed' => AppColors.success,
      'completed' => AppColors.iconMuted,
      'cancelled' => Colors.redAccent,
      'declined' => const Color(0xFFF59E0B),
      _ => AppColors.primary,
    };
    final label = switch (normalized) {
      'confirmed' => context.l10n.confirmed,
      'completed' => context.l10n.completed,
      'cancelled' => context.l10n.cancelled,
      'declined' => context.l10n.declined,
      _ => normalized,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .22),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w800,
          fontSize: 14,
        ),
      ),
    );
  }
}
