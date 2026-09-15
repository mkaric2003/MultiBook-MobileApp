import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/enums/support_ticket_status.dart';
import 'package:flutter/material.dart';

class SupportTicketStatusChip extends StatelessWidget {
  const SupportTicketStatusChip({required this.status, super.key});

  final SupportTicketStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      SupportTicketStatus.open => (
        context.l10n.supportStatusOpen,
        AppColors.primary,
      ),
      SupportTicketStatus.inProgress => (
        context.l10n.supportStatusInProgress,
        const Color(0xFFF59E0B),
      ),
      SupportTicketStatus.resolved => (
        context.l10n.supportStatusResolved,
        AppColors.success,
      ),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
