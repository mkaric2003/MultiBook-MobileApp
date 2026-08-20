import 'package:aquabook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:aquabook/src/features/customer-side/explore/domain/models/explore_category.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/customer_home_tab_selector.dart';
import 'package:aquabook/src/features/customer-side/explore/presentation/widgets/explore_destinations_list.dart';
import 'package:aquabook/src/features/customer-side/explore/presentation/widgets/explore_featured_collections.dart';
import 'package:aquabook/src/features/customer-side/explore/presentation/widgets/explore_promotion_carousel.dart';
import 'package:aquabook/src/features/customer-side/explore/presentation/widgets/explore_recently_viewed.dart';
import 'package:aquabook/src/features/customer-side/explore/presentation/widgets/explore_stay_category_grid.dart';
import 'package:flutter/material.dart';

class ExploreStaysContent extends StatelessWidget {
  const ExploreStaysContent({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
    required this.onCategorySelected,
  });

  final CustomerHomeTab selectedTab;
  final ValueChanged<CustomerHomeTab> onTabChanged;
  final ValueChanged<ExploreCategory> onCategorySelected;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
    children: [
      CustomerHomeTabSelector(
        selectedTab: selectedTab,
        onChanged: onTabChanged,
      ),
      const SizedBox(height: 26),
      const ExplorePromotionCarousel(),
      const SizedBox(height: 42),
      const Text(
        'Browse by category',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 18),
      ExploreStayCategoryGrid(onSelected: onCategorySelected),
      const SizedBox(height: 42),
      const Text(
        'Top destinations',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 18),
      const ExploreDestinationsList(),
      const SizedBox(height: 34),
      const Text(
        'Featured collections',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 18),
      const ExploreFeaturedCollections(),
      const SizedBox(height: 22),
      const Text(
        'Recently viewed',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 18),
      const ExploreRecentlyViewed(),
    ],
  );
}
