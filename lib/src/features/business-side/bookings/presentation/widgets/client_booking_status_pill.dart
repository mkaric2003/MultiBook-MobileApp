import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/enums/booking_status.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ClientBookingStatusPill extends StatelessWidget {
  const ClientBookingStatusPill({super.key, required this.status});

  final BookingStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      BookingStatus.confirmed => (
        context.l10n.confirmed,
        const Color(0xFF10B981),
      ),
      BookingStatus.declined => (
        context.l10n.declined,
        const Color(0xFFFB7185),
      ),
      BookingStatus.cancelled => (
        context.l10n.cancelled,
        const Color(0xFFFB7185),
      ),
      BookingStatus.completed => (
        context.l10n.completed,
        context.appPalette.muted,
      ),
      BookingStatus.noShow => (context.l10n.noShow, const Color(0xFFFB4B4B)),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .22),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 13,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
