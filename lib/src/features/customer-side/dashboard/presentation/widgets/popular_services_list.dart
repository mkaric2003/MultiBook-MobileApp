import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/service_listing_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PopularServicesList extends HookWidget {
  const PopularServicesList({
    required this.services,
    required this.isLoading,
    super.key,
  });

  final List<ServiceListing> services;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();

    if (isLoading) {
      return const SizedBox(
        height: 300,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (services.isEmpty) {
      return const SizedBox(
        height: 72,
        child: Center(
          child: Text(
            'No services available yet.',
            style: TextStyle(color: AppColors.muted),
          ),
        ),
      );
    }

    return SizedBox(
      height: 310,
      child: PageView.builder(
        controller: pageController,
        itemCount: services.length,
        itemBuilder: (context, index) =>
            ServiceListingCard(service: services[index]),
      ),
    );
  }
}
