import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/stay_listing_card.dart';
import 'package:flutter/material.dart';
import 'package:multibook/src/core/theme/app_colors.dart';

class OtherStaysGrid extends StatelessWidget {
  const OtherStaysGrid({
    super.key,
    required this.stays,
    required this.isLoading,
    this.emptyMessage,
  });

  final List<StayListing> stays;
  final bool isLoading;
  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (stays.isEmpty && !isLoading && emptyMessage != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Text(
              emptyMessage!,
              textAlign: TextAlign.center,
              style: TextStyle(color: context.appPalette.muted),
            ),
          ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: stays.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            mainAxisExtent: 280,
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
