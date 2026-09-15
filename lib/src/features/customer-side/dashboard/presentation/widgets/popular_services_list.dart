import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/customer_home_listing_skeleton.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/service_listing_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PopularServicesList extends HookWidget {
  const PopularServicesList({
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
            scrollController.position.maxScrollExtent - 180) {
          onLoadMore();
        }
      }

      scrollController.addListener(loadMoreWhenNeeded);
      return () => scrollController.removeListener(loadMoreWhenNeeded);
    }, [scrollController, hasMore, isLoadingMore, onLoadMore]);

    if (isLoading) {
      return const CustomerHomeListingSkeleton.horizontal(
        itemHeight: 280,
        imageHeight: 116,
      );
    }
    if (services.isEmpty) {
      return SizedBox(
        height: 72,
        child: Center(
          child: Text(
            'No services available yet.',
            style: TextStyle(color: context.appPalette.muted),
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
