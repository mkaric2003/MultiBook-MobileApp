import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/stay_listing_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RecommendedStaysList extends HookWidget {
  const RecommendedStaysList({
    super.key,
    required this.stays,
    required this.isLoading,
  });

  final List<StayListing> stays;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final currentIndex = useState(0);

    if (isLoading) {
      return const SizedBox(
        height: 300,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (stays.isEmpty) {
      return const SizedBox(
        height: 72,
        child: Center(
          child: Text(
            'No stays available yet.',
            style: TextStyle(color: AppColors.muted),
          ),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 310,
          child: PageView.builder(
            controller: pageController,
            itemCount: stays.length,
            onPageChanged: (index) => currentIndex.value = index,
            itemBuilder: (context, index) =>
                StayListingCard(stay: stays[index]),
          ),
        ),
      ],
    );
  }
}
