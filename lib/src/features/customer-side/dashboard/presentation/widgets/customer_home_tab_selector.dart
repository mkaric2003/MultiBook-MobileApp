import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/customer_home_tab_option.dart';
import 'package:flutter/material.dart';

class CustomerHomeTabSelector extends StatelessWidget {
  const CustomerHomeTabSelector({
    super.key,
    required this.selectedTab,
    required this.onChanged,
  });

  final CustomerHomeTab selectedTab;
  final ValueChanged<CustomerHomeTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CustomerHomeTabOption(
            label: context.l10n.stays,
            isSelected: selectedTab == CustomerHomeTab.stays,
            onTap: () => onChanged(CustomerHomeTab.stays),
          ),
          CustomerHomeTabOption(
            label: context.l10n.services,
            isSelected: selectedTab == CustomerHomeTab.services,
            onTap: () => onChanged(CustomerHomeTab.services),
          ),
        ],
      ),
    );
  }
}
