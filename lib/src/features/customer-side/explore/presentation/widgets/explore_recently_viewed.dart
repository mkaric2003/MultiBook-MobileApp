import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ExploreRecentlyViewed extends StatelessWidget {
  const ExploreRecentlyViewed({super.key});

  static const _items = [
    (
      'Hotel Luxe',
      'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=240&q=85',
    ),
    (
      'City Apartment',
      'https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?auto=format&fit=crop&w=240&q=85',
    ),
    (
      'Mountain Cabin',
      'https://images.unsplash.com/photo-1449158743715-0a90ebb6d2d8?auto=format&fit=crop&w=240&q=85',
    ),
    (
      'Beach Villa',
      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=240&q=85',
    ),
  ];

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 122,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: _items.length,
      separatorBuilder: (_, _) => const SizedBox(width: 14),
      itemBuilder: (_, index) {
        final item = _items[index];
        return SizedBox(
          width: 79,
          child: Column(
            children: [
              ClipOval(
                child: Image.network(
                  item.$2,
                  height: 66,
                  width: 66,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.$1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.muted, fontSize: 11),
              ),
            ],
          ),
        );
      },
    ),
  );
}
