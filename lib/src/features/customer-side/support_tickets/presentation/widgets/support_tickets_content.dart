import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/customer-side/support_tickets/cubit/support_tickets_state.dart';
import 'package:multibook/src/features/customer-side/support_tickets/presentation/widgets/support_ticket_card.dart';
import 'package:flutter/material.dart';

class SupportTicketsContent extends StatelessWidget {
  const SupportTicketsContent({required this.state, super.key});

  final SupportTicketsState state;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.tickets.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            context.l10n.noSupportRequests,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.muted, fontSize: 15),
          ),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      itemCount: state.tickets.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, index) =>
          SupportTicketCard(ticket: state.tickets[index]),
    );
  }
}
