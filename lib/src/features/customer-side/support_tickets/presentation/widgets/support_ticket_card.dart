import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/support_ticket_category.dart';
import 'package:aquabook/src/data/models/support_ticket_model.dart';
import 'package:aquabook/src/features/customer-side/support_tickets/presentation/widgets/support_ticket_status_chip.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SupportTicketCard extends StatelessWidget {
  const SupportTicketCard({required this.ticket, super.key});

  final SupportTicketModel ticket;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                ticket.subject,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 10),
            SupportTicketStatusChip(status: ticket.status),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _categoryLabel(context, ticket.category),
          style: const TextStyle(color: AppColors.primary, fontSize: 13),
        ),
        const SizedBox(height: 7),
        Text(
          ticket.message,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 14,
            height: 1.35,
          ),
        ),
        if (ticket.createdAt != null) ...[
          const SizedBox(height: 12),
          Text(
            DateFormat.yMMMd(
              Localizations.localeOf(context).toLanguageTag(),
            ).format(ticket.createdAt!),
            style: const TextStyle(color: AppColors.muted, fontSize: 12),
          ),
        ],
      ],
    ),
  );
}

String _categoryLabel(BuildContext context, SupportTicketCategory category) =>
    switch (category) {
      SupportTicketCategory.account => context.l10n.supportCategoryAccount,
      SupportTicketCategory.booking => context.l10n.supportCategoryBooking,
      SupportTicketCategory.appointment =>
        context.l10n.supportCategoryAppointment,
      SupportTicketCategory.payment => context.l10n.supportCategoryPayment,
      SupportTicketCategory.technical => context.l10n.supportCategoryTechnical,
      SupportTicketCategory.other => context.l10n.supportCategoryOther,
    };
