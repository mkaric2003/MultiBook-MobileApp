import 'package:flutter/material.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class InstagramBottomNavigation extends StatelessWidget {
  const InstagramBottomNavigation({
    required this.navBarConfig,
    required this.isCompact,
    super.key,
  });

  final NavBarConfig navBarConfig;
  final bool isCompact;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: const Duration(milliseconds: 260),
    curve: Curves.easeOutCubic,
    height: isCompact ? 58 : 68,
    margin: EdgeInsets.symmetric(
      horizontal: isCompact ? 18 : 0,
      vertical: isCompact ? 5 : 0,
    ),
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: context.appPalette.navigationSurface,
      borderRadius: BorderRadius.circular(34),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          blurRadius: 22,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth / navBarConfig.items.length;
        return Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              top: 0,
              bottom: 0,
              left: itemWidth * navBarConfig.selectedIndex,
              width: itemWidth,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.appPalette.navigationSelectedSurface,
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
            ),
            Row(
              children: navBarConfig.items.indexed.map((entry) {
                final index = entry.$1;
                final item = entry.$2;
                final isSelected = navBarConfig.selectedIndex == index;
                return Expanded(
                  child: Semantics(
                    selected: isSelected,
                    button: true,
                    label: item.title,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => navBarConfig.onItemSelected(index),
                      child: Center(
                        child: IconTheme(
                          data: IconThemeData(
                            size: item.iconSize,
                            color: isSelected
                                ? item.activeForegroundColor
                                : item.inactiveForegroundColor,
                          ),
                          child: isSelected ? item.icon : item.inactiveIcon,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    ),
  );
}
