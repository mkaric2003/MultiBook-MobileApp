import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/explore/domain/models/explore_category.dart';
import 'package:flutter/material.dart';

class ExploreStayCategoryGrid extends StatelessWidget {
  const ExploreStayCategoryGrid({super.key});

  static const _categories = [
    ExploreCategory(title: 'Hotels', icon: Icons.hotel_rounded),
    ExploreCategory(title: 'Apartments', icon: Icons.home_rounded),
    ExploreCategory(title: 'Villas', icon: Icons.villa_rounded),
    ExploreCategory(title: 'Beach villas', icon: Icons.beach_access_rounded),
    ExploreCategory(title: 'Mountain cabins', icon: Icons.forest_rounded),
    ExploreCategory(title: 'Weekend homes', icon: Icons.cottage_rounded),
    ExploreCategory(title: 'Pool villas', icon: Icons.pool_rounded),
    ExploreCategory(title: 'Resorts', icon: Icons.holiday_village_rounded),
  ];

  @override
  Widget build(BuildContext context) => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: _categories.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      childAspectRatio: 1.34,
    ),
    itemBuilder: (_, index) {
      final category = _categories[index];
      return Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(category.icon, color: AppColors.white, size: 27),
            ),
            const SizedBox(height: 12),
            Text(
              category.title,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      );
    },
  );
}
