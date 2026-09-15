import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/data/models/service_offering_model.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ServiceOfferingCard extends StatelessWidget {
  const ServiceOfferingCard({
    required this.offering,
    required this.onBook,
    super.key,
  });

  final ServiceOfferingModel offering;
  final VoidCallback onBook;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.appPalette.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offering.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (offering.description?.isNotEmpty ?? false) ...[
                  const SizedBox(height: 4),
                  Text(
                    offering.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: context.appPalette.muted,
                      fontSize: 13,
                    ),
                  ),
                ],
                const SizedBox(height: 9),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      color: context.appPalette.muted,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      context.l10n.serviceDuration(offering.durationMinutes),
                      style: TextStyle(color: context.appPalette.muted),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      context.l10n.formatCurrency(offering.price),
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 76,
            child: CustomButton(
              buttonName: context.l10n.book,
              horizontalPadding: 12,
              onPressed: onBook,
            ),
          ),
        ],
      ),
    );
  }
}
