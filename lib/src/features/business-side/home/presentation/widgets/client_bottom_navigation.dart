import 'package:multibook/src/features/business-side/home/domain/models/client_navigation_item.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class ClientBottomNavigation extends StatelessWidget {
  const ClientBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    ClientNavigationItem(label: 'Dashboard', icon: Icons.home_rounded),
    ClientNavigationItem(label: 'Bookings', icon: Icons.calendar_month_rounded),
    ClientNavigationItem(
      label: 'Earnings',
      icon: Icons.account_balance_wallet_rounded,
    ),
    ClientNavigationItem(label: 'More', icon: Icons.menu_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appPalette.navigationSurface,
      child: SafeArea(
        top: false,
        child: Container(
          height: 58,
          decoration: BoxDecoration(
            color: context.appPalette.navigationSurface,
            border: Border(
              top: BorderSide(color: context.appPalette.navigationBorder),
            ),
          ),
          child: Row(
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final isSelected = index == currentIndex;
              final color = isSelected
                  ? const Color.fromARGB(255, 166, 131, 245)
                  : context.appPalette.muted;

              return Expanded(
                child: InkWell(
                  onTap: () => onTap(index),
                  child: Semantics(
                    selected: isSelected,
                    button: true,
                    label: item.label,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item.icon, color: color, size: 25),
                        const SizedBox(height: 5),
                        FittedBox(
                          child: Text(
                            item.label,
                            style: TextStyle(
                              color: color,
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
