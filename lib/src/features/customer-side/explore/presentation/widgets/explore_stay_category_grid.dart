import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/customer-side/explore/domain/models/explore_category.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ExploreStayCategoryGrid extends StatelessWidget {
  const ExploreStayCategoryGrid({required this.onSelected, super.key});

  final ValueChanged<ExploreCategory> onSelected;

  static const _categories = [
    ExploreCategory(id: 'hotel', title: 'Hotels', icon: Icons.hotel_rounded),
    ExploreCategory(
      id: 'apartment',
      title: 'Apartments',
      icon: Icons.home_rounded,
    ),
    ExploreCategory(id: 'villa', title: 'Villas', icon: Icons.villa_rounded),
    ExploreCategory(
      id: 'beach_villa',
      title: 'Beach villas',
      icon: Icons.beach_access_rounded,
    ),
    ExploreCategory(
      id: 'mountain_cabin',
      title: 'Mountain cabins',
      icon: Icons.forest_rounded,
    ),
    ExploreCategory(
      id: 'cottage',
      title: 'Weekend homes',
      icon: Icons.cottage_rounded,
    ),
    ExploreCategory(
      id: 'pool_villa',
      title: 'Pool villas',
      icon: Icons.pool_rounded,
    ),
    ExploreCategory(
      id: 'resort',
      title: 'Resorts',
      icon: Icons.holiday_village_rounded,
    ),
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
      return InkWell(
        onTap: () => onSelected(category),
        borderRadius: BorderRadius.circular(18),
        child: Container(
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
                context.l10n.businessCategoryName(category.id),
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      );
    },
  );
}
