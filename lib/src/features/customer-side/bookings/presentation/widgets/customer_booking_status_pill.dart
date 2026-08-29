import 'package:multibook/src/data/enums/booking_status.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class CustomerBookingStatusPill extends StatelessWidget {
  const CustomerBookingStatusPill({super.key, required this.status});

  final BookingStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      BookingStatus.confirmed => (
        context.l10n.confirmed,
        const Color(0xFF22C55E),
      ),
      BookingStatus.declined => (
        context.l10n.declined,
        const Color(0xFFF59E0B),
      ),
      BookingStatus.cancelled => (
        context.l10n.cancelled,
        const Color(0xFFEF4444),
      ),
      BookingStatus.completed => (
        context.l10n.completed,
        const Color(0xFF3B82F6),
      ),
      BookingStatus.noShow => (context.l10n.noShow, const Color(0xFFEF4444)),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .16),
        border: Border.all(color: color.withValues(alpha: .7)),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
