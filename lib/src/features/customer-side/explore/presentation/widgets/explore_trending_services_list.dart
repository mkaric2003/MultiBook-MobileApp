import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/explore/domain/models/explore_service_preview.dart';
import 'package:flutter/material.dart';

class ExploreTrendingServicesList extends StatelessWidget {
  const ExploreTrendingServicesList({super.key});

  static const _services = [
    ExploreServicePreview(
      name: 'Style Studio',
      category: 'Hair & Beauty',
      imageUrl:
          'https://images.unsplash.com/photo-1560066984-138dadb4c035?auto=format&fit=crop&w=650&q=85',
      rating: 4.8,
      reviewCount: 124,
      startingPrice: 45,
    ),
    ExploreServicePreview(
      name: 'Bright Dental',
      category: 'Dental Care',
      imageUrl:
          'https://images.unsplash.com/photo-1629909613654-28e377c37b09?auto=format&fit=crop&w=650&q=85',
      rating: 4.9,
      reviewCount: 89,
      startingPrice: 65,
    ),
    ExploreServicePreview(
      name: 'Zen Spa',
      category: 'Wellness',
      imageUrl:
          'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?auto=format&fit=crop&w=650&q=85',
      rating: 4.7,
      reviewCount: 76,
      startingPrice: 55,
    ),
  ];

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 220,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: _services.length,
      separatorBuilder: (_, _) => const SizedBox(width: 14),
      itemBuilder: (_, index) {
        final service = _services[index];
        return SizedBox(
          width: 238,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: DecoratedBox(
              decoration: const BoxDecoration(color: AppColors.surface),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    service.imageUrl,
                    height: 116,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 11, 14, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            service.category,
                            style: const TextStyle(
                              color: AppColors.muted,
                              fontSize: 12,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Color(0xFFFFC928),
                                size: 16,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                '${service.rating} (${service.reviewCount})',
                                style: const TextStyle(fontSize: 12),
                              ),
                              const Spacer(),
                              Text(
                                'from \$${service.startingPrice}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
