import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:flutter/material.dart';

class CustomerServiceSearchResultTile extends StatelessWidget {
  const CustomerServiceSearchResultTile({required this.service, super.key});

  final ServiceListing service;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
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
              errorBuilder: (_, _, _) => const SizedBox(
                height: 78,
                width: 78,
                child: ColoredBox(color: AppColors.surfaceHighlight),
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
                  style: const TextStyle(color: AppColors.muted),
                ),
                if (service.price != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    'From \$${service.price}${service.durationMinutes == null ? '' : ' · ${service.durationMinutes} min'}',
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
    );
  }
}
