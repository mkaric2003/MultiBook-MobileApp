import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/customer_home_tab_selector.dart';
import 'package:flutter/material.dart';

class ExploreServicesPlaceholder extends StatelessWidget {
  const ExploreServicesPlaceholder({required this.onBackToStays, super.key});

  final VoidCallback onBackToStays;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
    child: Column(
      children: [
        CustomerHomeTabSelector(
          selectedTab: CustomerHomeTab.services,
          onChanged: (tab) {
            if (tab == CustomerHomeTab.stays) onBackToStays();
          },
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Service exploration is coming soon.',
              style: TextStyle(color: AppColors.muted, fontSize: 16),
            ),
          ),
        ),
      ],
    ),
  );
}
