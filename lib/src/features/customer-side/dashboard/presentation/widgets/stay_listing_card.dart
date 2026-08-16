import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:flutter/material.dart';

class StayListingCard extends StatelessWidget {
  const StayListingCard({super.key, required this.stay, this.compact = false});

  final StayListing stay;
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
                stay.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '⭐ ${stay.rating.toStringAsFixed(1)} (${stay.reviewCount})${stay.location.isEmpty ? '' : '  •  ${stay.location}'}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: AppColors.muted, fontSize: 13),
              ),
              if (stay.pricePerNight != null) ...[
                if (pinPriceToBottom)
                  const Spacer()
                else
                  const SizedBox(height: 6),
                Text(
                  '\$${stay.pricePerNight}/night',
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
              Stack(
                children: [
                  Image.network(
                    stay.imageUrl,
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
                  if (stay.isFeatured)
                    Positioned(
                      right: 12,
                      bottom: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'Featured',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              if (pinPriceToBottom) Expanded(child: details) else details,
            ],
          ),
        );
      },
    );
  }
}
