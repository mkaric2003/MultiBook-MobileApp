import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/app.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:aquabook/src/features/business-side/promotions/presentation/widgets/promotion_badge.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ServiceListingCard extends StatelessWidget {
  const ServiceListingCard({
    required this.service,
    this.compact = false,
    super.key,
  });

  final ServiceListing service;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final imageHeight = compact ? 116.0 : 175.0;
    final detailsPadding = compact
        ? const EdgeInsets.fromLTRB(13, 10, 13, 10)
        : const EdgeInsets.fromLTRB(13, 12, 13, 13);

    return LayoutBuilder(
      builder: (context, constraints) {
        final pinPriceToBottom = constraints.hasBoundedHeight;
        final details = Padding(
          padding: detailsPadding,
          child: Column(
            mainAxisSize: pinPriceToBottom
                ? MainAxisSize.max
                : MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                service.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '⭐ ${service.rating.toStringAsFixed(1)} (${service.reviewCount})',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: AppColors.muted, fontSize: 13),
              ),
              if (service.location.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  service.location,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColors.muted, fontSize: 13),
                ),
              ],
              if (service.durationMinutes != null) ...[
                const SizedBox(height: 5),
                Text(
                  context.l10n.appointmentDuration(service.durationMinutes!),
                  style: const TextStyle(color: AppColors.muted, fontSize: 13),
                ),
              ],
              if (service.price != null) ...[
                if (pinPriceToBottom)
                  const Spacer()
                else
                  const SizedBox(height: 6),
                Text(
                  context.l10n.fromPrice(
                    context.l10n.formatCurrency(service.price ?? 0),
                  ),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ],
          ),
        );

        return GestureDetector(
          onTap: () => context.push(AppRoutes.SERVICE_DETAIL, extra: service),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(13),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      service.imageUrl,
                      height: imageHeight,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => SizedBox(
                        height: imageHeight,
                        child: const ColoredBox(
                          color: AppColors.surfaceHighlight,
                        ),
                      ),
                    ),
                    if (service.isPromotionActive)
                      Positioned(
                        right: -25,
                        top: 14,
                        child: const PromotionBadge(),
                      ),
                  ],
                ),
                if (pinPriceToBottom) Expanded(child: details) else details,
              ],
            ),
          ),
        );
      },
    );
  }
}
