import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/customer-side/review_appointment/domain/models/review_appointment_arguments.dart';
import 'package:multibook/src/features/customer-side/review_appointment/presentation/widgets/appointment_summary_row.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentReviewSummaryCard extends StatelessWidget {
  const AppointmentReviewSummaryCard({required this.arguments, super.key});

  final ReviewAppointmentArguments arguments;

  @override
  Widget build(BuildContext context) {
    final totalDuration = arguments.offerings.fold(
      0,
      (total, offering) => total + offering.durationMinutes,
    );
    final basePrice = arguments.offerings.fold(
      0,
      (total, offering) => total + offering.price,
    );
    final start = DateTime(
      2000,
      1,
      1,
    ).add(Duration(minutes: arguments.startMinutes));
    final end = start.add(Duration(minutes: totalDuration));
    final imageUrl =
        arguments.business.logoUrl ?? arguments.business.coverPhotoUrl ?? '';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.appPalette.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appPalette.surfaceHighlight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => SizedBox(
                    width: 64,
                    height: 64,
                    child: ColoredBox(
                      color: context.appPalette.surfaceHighlight,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      arguments.business.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      arguments.offerings
                          .map((offering) => offering.name)
                          .join(', '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: context.appPalette.muted),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '⭐ ${arguments.business.averageRating.toStringAsFixed(1)} (${context.l10n.reviews(arguments.business.reviewCount)})',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          AppointmentSummaryRow(
            label: context.l10n.duration,
            value: context.l10n.serviceDuration(totalDuration),
          ),
          const SizedBox(height: 12),
          AppointmentSummaryRow(
            label: context.l10n.provider,
            value: arguments.provider.name,
          ),
          const SizedBox(height: 12),
          AppointmentSummaryRow(
            label: context.l10n.date,
            value: DateFormat('EEE, MMM d').format(arguments.date),
          ),
          const SizedBox(height: 12),
          AppointmentSummaryRow(
            label: context.l10n.time,
            value:
                '${DateFormat('h:mm a').format(start)} - ${DateFormat('h:mm a').format(end)}',
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: context.appPalette.surfaceHighlight),
          ),
          AppointmentSummaryRow(
            label: context.l10n.pricePerSession,
            value: context.l10n.formatCurrency(basePrice),
          ),
          const SizedBox(height: 12),
          AppointmentSummaryRow(
            label: context.l10n.total,
            value: context.l10n.formatCurrency(basePrice),
            emphasized: true,
          ),
        ],
      ),
    );
  }
}
