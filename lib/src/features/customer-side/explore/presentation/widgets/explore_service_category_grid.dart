import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/customer-side/explore/domain/models/explore_service_category.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ExploreServiceCategoryGrid extends StatelessWidget {
  const ExploreServiceCategoryGrid({
    required this.categories,
    required this.onSelected,
    super.key,
  });

  final List<ExploreServiceCategory> categories;
  final ValueChanged<ExploreServiceCategory> onSelected;

  @override
  Widget build(BuildContext context) => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: categories.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      mainAxisExtent: 108,
    ),
    itemBuilder: (_, index) {
      final category = categories[index];
      return InkWell(
        onTap: () => onSelected(category),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: category.color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(category.icon, color: AppColors.primary, size: 24),
              ),
              const SizedBox(height: 9),
              Text(
                context.l10n.businessCategoryName(category.id),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
