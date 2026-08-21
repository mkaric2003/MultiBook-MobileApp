import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/service_listing_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExploreTrendingServicesList extends HookWidget {
  const ExploreTrendingServicesList({
    required this.services,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasMore,
    required this.onLoadMore,
    super.key,
  });

  final List<ServiceListing> services;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final Future<void> Function() onLoadMore;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    useEffect(() {
      void loadMoreWhenNeeded() {
        if (!scrollController.hasClients || !hasMore || isLoadingMore) return;
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 160) {
          onLoadMore();
        }
      }

      scrollController.addListener(loadMoreWhenNeeded);
      return () => scrollController.removeListener(loadMoreWhenNeeded);
    }, [scrollController, hasMore, isLoadingMore, onLoadMore]);

    if (isLoading) {
      return const SizedBox(
        height: 280,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (services.isEmpty) {
      return const SizedBox(
        height: 72,
        child: Center(
          child: Text(
            'No services available in this city yet.',
            style: TextStyle(color: AppColors.muted),
          ),
        ),
      );
    }

    return SizedBox(
      height: 280,
      child: ListView.separated(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: services.length + (isLoadingMore ? 1 : 0),
        separatorBuilder: (_, _) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          if (index == services.length) {
            return const SizedBox(
              width: 64,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return SizedBox(
            width: 180,
            child: ServiceListingCard(service: services[index], compact: true),
          );
        },
      ),
    );
  }
}
