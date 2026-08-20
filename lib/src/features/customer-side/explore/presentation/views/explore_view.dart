import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/customer_home_tab_selector.dart';
import 'package:aquabook/src/features/customer-side/explore/presentation/widgets/explore_app_bar.dart';
import 'package:aquabook/src/features/customer-side/explore/presentation/widgets/explore_stays_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExploreView extends HookWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(CustomerHomeTab.stays);

    return SafeArea(
      child: Column(
        children: [
          const ExploreAppBar(),
          Expanded(
            child: selectedTab.value == CustomerHomeTab.stays
                ? ExploreStaysContent(
                    selectedTab: selectedTab.value,
                    onTabChanged: (tab) => selectedTab.value = tab,
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                        child: CustomerHomeTabSelector(
                          selectedTab: selectedTab.value,
                          onChanged: (tab) => selectedTab.value = tab,
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Services exploration is coming soon.',
                            style: TextStyle(color: AppColors.muted),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
