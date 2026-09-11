import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/app.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomerServiceSearchResultTile extends StatelessWidget {
  const CustomerServiceSearchResultTile({required this.service, super.key});

  final ServiceListing service;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.SERVICE_DETAIL, extra: service),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: context.appPalette.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                service.imageUrl,
                height: 78,
                width: 78,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => SizedBox(
                  height: 78,
                  width: 78,
                  child: ColoredBox(color: context.appPalette.surfaceHighlight),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    service.location,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: context.appPalette.muted),
                  ),
                  if (service.price != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      '${context.l10n.fromPrice(context.l10n.formatCurrency(service.price ?? 0))}${service.durationMinutes == null ? '' : ' · ${context.l10n.serviceDuration(service.durationMinutes!)}'}',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
