import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:multibook/src/features/customer-side/search/presentation/widgets/customer_service_search_result_tile.dart';
import 'package:flutter/material.dart';

class CustomerServiceSearchResultsList extends StatelessWidget {
  const CustomerServiceSearchResultsList({
    required this.query,
    required this.services,
    required this.isLoading,
    super.key,
  });

  final String query;
  final List<ServiceListing> services;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text(
          'Search by a business name or city.',
          style: TextStyle(color: context.appPalette.muted, fontSize: 16),
        ),
      );
    }
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (services.isEmpty) {
      return Center(
        child: Text(
          'No services found.',
          style: TextStyle(color: context.appPalette.muted, fontSize: 16),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(top: 20, bottom: 28),
      itemCount: services.length,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (context, index) =>
          CustomerServiceSearchResultTile(service: services[index]),
    );
  }
}
