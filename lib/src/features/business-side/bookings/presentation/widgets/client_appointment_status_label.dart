import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
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
      'no_show' => Colors.redAccent,
      _ => AppColors.primary,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _label(context),
        style: TextStyle(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }

  String _label(BuildContext context) => switch (status) {
    'confirmed' => context.l10n.confirmed,
    'cancelled' => context.l10n.cancelled,
    'declined' => context.l10n.declined,
    'completed' => context.l10n.completed,
    'no_show' => context.l10n.noShow,
    _ => status,
  };
}
