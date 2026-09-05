import 'package:multibook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/customer_home_tab_selector.dart';
import 'package:multibook/src/features/customer-side/explore/domain/models/explore_service_category_catalog.dart';
import 'package:multibook/src/features/customer-side/explore/domain/models/explore_service_category.dart';
import 'package:multibook/src/features/customer-side/explore/domain/models/explore_service_collection.dart';
import 'package:multibook/src/features/customer-side/explore/presentation/widgets/explore_recent_services.dart';
import 'package:multibook/src/features/customer-side/explore/presentation/widgets/explore_service_category_grid.dart';
import 'package:multibook/src/features/customer-side/explore/presentation/widgets/explore_service_collections.dart';
import 'package:multibook/src/features/customer-side/explore/presentation/widgets/explore_service_promotion_carousel.dart';
import 'package:multibook/src/features/customer-side/explore/presentation/widgets/explore_trending_services_list.dart';
import 'package:multibook/src/features/customer-side/explore/presentation/widgets/explore_view_all_categories_button.dart';
import 'package:multibook/src/data/models/featured_collection_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExploreServicesContent extends HookWidget {
  const ExploreServicesContent({
    required this.selectedTab,
    required this.onTabChanged,
    required this.onCategorySelected,
    required this.onCollectionSelected,
    required this.collections,
    required this.trendingServices,
    required this.isTrendingServicesLoading,
    required this.isLoadingMoreTrendingServices,
    required this.hasMoreTrendingServices,
    required this.onLoadMoreTrendingServices,
    super.key,
  });

  final CustomerHomeTab selectedTab;
  final ValueChanged<CustomerHomeTab> onTabChanged;
  final ValueChanged<ExploreServiceCategory> onCategorySelected;
  final ValueChanged<ExploreServiceCollection> onCollectionSelected;
  final List<FeaturedCollectionModel> collections;
  final List<ServiceListing> trendingServices;
  final bool isTrendingServicesLoading;
  final bool isLoadingMoreTrendingServices;
  final bool hasMoreTrendingServices;
  final Future<void> Function() onLoadMoreTrendingServices;

  @override
  Widget build(BuildContext context) {
    final showAllCategories = useState(false);
    final categories = showAllCategories.value
        ? ExploreServiceCategoryCatalog.all
        : ExploreServiceCategoryCatalog.primary;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
      children: [
        CustomerHomeTabSelector(
          selectedTab: selectedTab,
          onChanged: onTabChanged,
        ),
        const SizedBox(height: 34),
        const ExploreServicePromotionCarousel(),
        const SizedBox(height: 42),
        Text(
          context.l10n.browseByCategory,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 18),
        ExploreServiceCategoryGrid(
          categories: categories,
          onSelected: onCategorySelected,
        ),
        const SizedBox(height: 6),
        ExploreViewAllCategoriesButton(
          isExpanded: showAllCategories.value,
          onPressed: () => showAllCategories.value = !showAllCategories.value,
        ),
        const SizedBox(height: 42),
        Text(
          context.l10n.trendingNearYou,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 18),
        ExploreTrendingServicesList(
          services: trendingServices,
          isLoading: isTrendingServicesLoading,
          isLoadingMore: isLoadingMoreTrendingServices,
          hasMore: hasMoreTrendingServices,
          onLoadMore: onLoadMoreTrendingServices,
        ),
        const SizedBox(height: 38),
        Text(
          context.l10n.featuredCollections,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 18),
        ExploreServiceCollections(
          collections: collections,
          onSelected: onCollectionSelected,
        ),
        const ExploreRecentServices(),
      ],
    );
  }
}
