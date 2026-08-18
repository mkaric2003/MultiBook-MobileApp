import 'package:aquabook/app.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SavedBusinessCard extends StatelessWidget {
  const SavedBusinessCard({
    super.key,
    required this.stay,
    required this.onRemove,
  });
  final StayListing stay;
  final VoidCallback onRemove;
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(18),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.network(
              stay.imageUrl,
              height: 190,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const SizedBox(
                height: 190,
                child: ColoredBox(color: AppColors.surfaceHighlight),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.favorite, color: Colors.red),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stay.name,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                stay.location,
                style: const TextStyle(color: AppColors.muted),
              ),
              const SizedBox(height: 8),
              Text(
                '⭐ ${stay.rating.toStringAsFixed(1)} (${stay.reviewCount} reviews)',
                style: const TextStyle(color: AppColors.muted),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Text(
                    '\$${stay.pricePerNight ?? 0}/night',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  FilledButton(
                    onPressed: () =>
                        context.push(AppRoutes.STAY_DETAIL, extra: stay),
                    child: const Text('View details'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
