import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/stay_listing_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NearbyStaysList extends HookWidget {
  const NearbyStaysList({
    required this.stays,
    required this.isLoadingMore,
    required this.hasMore,
    required this.onLoadMore,
    super.key,
  });

  final List<StayListing> stays;
  final bool isLoadingMore;
  final bool hasMore;
  final Future<void> Function() onLoadMore;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    useEffect(() {
      void loadMoreWhenNeeded() {
        if (!scrollController.hasClients || !hasMore || isLoadingMore) {
          return;
        }
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 180) {
          onLoadMore();
        }
      }

      scrollController.addListener(loadMoreWhenNeeded);
      return () => scrollController.removeListener(loadMoreWhenNeeded);
    }, [scrollController, hasMore, isLoadingMore, onLoadMore]);

    return SizedBox(
      height: 280,
      child: ListView.separated(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: stays.length + (isLoadingMore ? 1 : 0),
        separatorBuilder: (_, _) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          if (index == stays.length) {
            return const SizedBox(
              width: 64,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return SizedBox(
            width: 180,
            child: StayListingCard(stay: stays[index], compact: true),
          );
        },
      ),
    );
  }
}
