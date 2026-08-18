import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/features/customer-side/search/presentation/widgets/customer_search_result_tile.dart';
import 'package:flutter/material.dart';

class CustomerSearchResultsList extends StatelessWidget {
  const CustomerSearchResultsList({
    super.key,
    required this.query,
    required this.stays,
    required this.isLoading,
  });

  final String query;
  final List<StayListing> stays;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text(
          'Search by a stay name or city.',
          style: TextStyle(color: AppColors.muted, fontSize: 16),
        ),
      );
    }
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (stays.isEmpty) {
      return const Center(
        child: Text(
          'No stays found.',
          style: TextStyle(color: AppColors.muted, fontSize: 16),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(top: 20, bottom: 28),
      itemCount: stays.length,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (context, index) =>
          CustomerSearchResultTile(stay: stays[index]),
    );
  }
}
