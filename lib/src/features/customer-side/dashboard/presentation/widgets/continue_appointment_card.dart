import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/data/models/appointment_draft_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContinueAppointmentCard extends StatelessWidget {
  const ContinueAppointmentCard({
    required this.draft,
    required this.onTap,
    super.key,
  });

  final AppointmentDraftModel draft;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(14),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.event_available, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.continueAppointment,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                if (draft.selectedProviderName?.isNotEmpty ?? false) ...[
                  const SizedBox(height: 4),
                  Text(
                    context.l10n.withProvider(draft.selectedProviderName!),
                    style: const TextStyle(color: AppColors.muted),
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  '${draft.businessName} · ${DateFormat('dd.MM').format(draft.date)}',
                  style: const TextStyle(color: AppColors.muted),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.muted),
        ],
      ),
    ),
  );
}
