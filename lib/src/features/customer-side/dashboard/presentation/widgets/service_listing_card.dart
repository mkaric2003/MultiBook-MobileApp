import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:flutter/material.dart';

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
    final imageHeight = compact ? 134.0 : 175.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final pinPriceToBottom = constraints.hasBoundedHeight;
        final details = Padding(
          padding: const EdgeInsets.fromLTRB(13, 12, 13, 13),
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
                '⭐ ${service.rating.toStringAsFixed(1)} (${service.reviewCount})${service.location.isEmpty ? '' : '  •  ${service.location}'}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: AppColors.muted, fontSize: 13),
              ),
              if (service.durationMinutes != null) ...[
                const SizedBox(height: 5),
                Text(
                  '${service.durationMinutes} min appointment',
                  style: const TextStyle(color: AppColors.muted, fontSize: 13),
                ),
              ],
              if (service.price != null) ...[
                if (pinPriceToBottom)
                  const Spacer()
                else
                  const SizedBox(height: 6),
                Text(
                  'From \$${service.price}',
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

        return Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(13),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                service.imageUrl,
                height: imageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => SizedBox(
                  height: imageHeight,
                  child: const ColoredBox(color: AppColors.surfaceHighlight),
                ),
              ),
              if (pinPriceToBottom) Expanded(child: details) else details,
            ],
          ),
        );
      },
    );
  }
}
