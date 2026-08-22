import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/features/customer-side/explore/domain/models/explore_destination.dart';
import 'package:flutter/material.dart';

class ExploreDestinationsList extends StatelessWidget {
  const ExploreDestinationsList({super.key});

  static const _destinations = [
    ExploreDestination(
      name: 'Paris',
      startingPrice: 89,
      imageUrl:
          'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?auto=format&fit=crop&w=480&q=85',
    ),
    ExploreDestination(
      name: 'Tokyo',
      startingPrice: 65,
      imageUrl:
          'https://images.unsplash.com/photo-1503899036084-c55cdd92da26?auto=format&fit=crop&w=480&q=85',
    ),
    ExploreDestination(
      name: 'New York',
      startingPrice: 120,
      imageUrl:
          'https://images.unsplash.com/photo-1485871981521-5b1fd3805eee?auto=format&fit=crop&w=480&q=85',
    ),
  ];

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 160,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: _destinations.length,
      separatorBuilder: (_, _) => const SizedBox(width: 14),
      itemBuilder: (_, index) {
        final destination = _destinations[index];
        return SizedBox(
          width: 145,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  destination.imageUrl,
                  height: 105,
                  width: 145,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                destination.name,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 2),
              Text(
                context.l10n.fromPrice(
                  '\$${destination.startingPrice}${context.l10n.perNight}',
                ),
                style: const TextStyle(color: AppColors.muted, fontSize: 12),
              ),
            ],
          ),
        );
      },
    ),
  );
}
