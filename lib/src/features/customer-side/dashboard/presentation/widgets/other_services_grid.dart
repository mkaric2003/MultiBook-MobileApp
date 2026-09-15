import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/service_listing_card.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/customer_home_listing_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:multibook/src/core/theme/app_colors.dart';

class OtherServicesGrid extends StatelessWidget {
  const OtherServicesGrid({
    required this.services,
    required this.isLoading,
    this.emptyMessage,
    super.key,
  });

  final List<ServiceListing> services;
  final bool isLoading;
  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (services.isEmpty && !isLoading && emptyMessage != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Text(
              emptyMessage!,
              textAlign: TextAlign.center,
              style: TextStyle(color: context.appPalette.muted),
            ),
          ),
        if (isLoading && services.isEmpty)
          const CustomerHomeListingSkeleton.grid(
            itemHeight: 275,
            imageHeight: 116,
          )
        else
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
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
        if (isLoading && services.isNotEmpty) ...[
          const SizedBox(height: 20),
          const Center(child: CircularProgressIndicator()),
        ],
      ],
    );
  }
}
