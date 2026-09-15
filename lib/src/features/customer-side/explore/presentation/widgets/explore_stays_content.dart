import 'package:flutter/material.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/data/models/featured_collection_model.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/customer_home_tab_selector.dart';
import 'package:multibook/src/features/customer-side/explore/domain/models/explore_category.dart';
import 'package:multibook/src/features/customer-side/explore/domain/models/explore_collection.dart';
import 'package:multibook/src/features/customer-side/explore/presentation/widgets/explore_featured_collections.dart';
import 'package:multibook/src/features/customer-side/explore/presentation/widgets/explore_promotion_carousel.dart';
import 'package:multibook/src/features/customer-side/explore/presentation/widgets/explore_recently_viewed.dart';
import 'package:multibook/src/features/customer-side/explore/presentation/widgets/explore_stay_category_grid.dart';

class ExploreStaysContent extends StatelessWidget {
  const ExploreStaysContent({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
    required this.onCategorySelected,
    required this.onCollectionSelected,
    required this.collections,
  });

  final CustomerHomeTab selectedTab;
  final ValueChanged<CustomerHomeTab> onTabChanged;
  final ValueChanged<ExploreCategory> onCategorySelected;
  final ValueChanged<ExploreCollection> onCollectionSelected;
  final List<FeaturedCollectionModel> collections;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 100),
    children: [
      CustomerHomeTabSelector(
        selectedTab: selectedTab,
        onChanged: onTabChanged,
      ),
      const SizedBox(height: 26),
      const ExplorePromotionCarousel(),
      const SizedBox(height: 42),
      Text(
        context.l10n.browseByCategory,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 18),
      ExploreStayCategoryGrid(onSelected: onCategorySelected),

      const SizedBox(height: 10),
      Text(
        context.l10n.featuredCollections,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 18),
      ExploreFeaturedCollections(
        collections: collections,
        onSelected: onCollectionSelected,
      ),
      const ExploreRecentlyViewed(),
    ],
  );
}
