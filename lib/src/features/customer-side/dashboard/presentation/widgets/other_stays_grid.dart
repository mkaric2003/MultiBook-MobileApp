import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/stay_listing_card.dart';
import 'package:flutter/material.dart';

class OtherStaysGrid extends StatelessWidget {
  const OtherStaysGrid({
    super.key,
    required this.stays,
    required this.isLoading,
  });

  final List<StayListing> stays;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: stays.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            mainAxisExtent: 260,
          ),
          itemBuilder: (context, index) =>
              StayListingCard(stay: stays[index], compact: true),
        ),
        if (isLoading) ...[
          const SizedBox(height: 20),
          const Center(child: CircularProgressIndicator()),
        ],
      ],
    );
  }
}
