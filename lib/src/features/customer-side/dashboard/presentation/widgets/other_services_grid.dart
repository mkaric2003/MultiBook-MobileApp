import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/service_listing_card.dart';
import 'package:flutter/material.dart';

class OtherServicesGrid extends StatelessWidget {
  const OtherServicesGrid({
    required this.services,
    required this.isLoading,
    super.key,
  });

  final List<ServiceListing> services;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: services.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            mainAxisExtent: 275,
          ),
          itemBuilder: (context, index) =>
              ServiceListingCard(service: services[index], compact: true),
        ),
        if (isLoading) ...[
          const SizedBox(height: 20),
          const Center(child: CircularProgressIndicator()),
        ],
      ],
    );
  }
}
