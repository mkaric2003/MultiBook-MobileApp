import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/home/domain/models/customer_navigation_item.dart';
import 'package:flutter/material.dart';

class CustomerBottomNavigation extends StatelessWidget {
  const CustomerBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    CustomerNavigationItem(label: 'Home', icon: Icons.home_rounded),
    CustomerNavigationItem(label: 'Explore', icon: Icons.explore_rounded),
    CustomerNavigationItem(
      label: 'Bookings',
      icon: Icons.calendar_month_rounded,
    ),
    CustomerNavigationItem(label: 'Saved', icon: Icons.favorite_rounded),
    CustomerNavigationItem(label: 'Profile', icon: Icons.person_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceHighlight,
      child: SafeArea(
        top: false,
        child: Container(
          height: 68,
          decoration: const BoxDecoration(
            color: AppColors.surfaceHighlight,
            border: Border(top: BorderSide(color: Color(0xFF46465C))),
          ),
          child: Row(
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final isSelected = index == currentIndex;
              final color = isSelected
                  ? const Color.fromARGB(255, 166, 131, 245)
                  : const Color(0xFF9CA3AF);

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
                        Icon(item.icon, color: color, size: 31),
                        const SizedBox(height: 9),
                        FittedBox(
                          child: Text(
                            item.label,
                            style: TextStyle(
                              color: color,
                              fontSize: 15,
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
