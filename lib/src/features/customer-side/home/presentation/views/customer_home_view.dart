import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/customer-side/bookings/presentation/views/customer_bookings_view.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/views/customer_dashboard_view.dart';
import 'package:multibook/src/features/customer-side/explore/presentation/views/explore_view.dart';
import 'package:multibook/src/features/customer-side/home/bloc/customer_home_bloc.dart';
import 'package:multibook/src/features/customer-side/home/bloc/customer_home_event.dart';
import 'package:multibook/src/features/customer-side/home/bloc/customer_home_state.dart';
import 'package:multibook/src/features/customer-side/profile/presentation/views/customer_profile_view.dart';
import 'package:multibook/src/features/customer-side/saved/presentation/views/saved_view.dart';
import 'package:multibook/src/global_widgets/instagram_bottom_navigation.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomerHomeView extends HookWidget {
  const CustomerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(PersistentTabController.new);
    final isNavigationCompact = useState(false);
    useEffect(() => controller.dispose, [controller]);

    return BlocProvider(
      create: (_) => CustomerHomeBloc(),
      child: BlocConsumer<CustomerHomeBloc, CustomerHomeState>(
        listener: (context, state) {
          if (controller.index != state.currentTabIndex) {
            controller.jumpToTab(state.currentTabIndex);
          }
        },
        builder: (context, state) {
          final isLight = Theme.of(context).brightness == Brightness.light;
          final activeColor = isLight ? AppColors.primary : AppColors.white;
          final inactiveColor = isLight
              ? context.appPalette.muted
              : context.appPalette.foreground.withValues(alpha: 0.78);
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.axis != Axis.vertical) return false;
              if (notification.direction == ScrollDirection.reverse &&
                  !isNavigationCompact.value) {
                isNavigationCompact.value = true;
              } else if (notification.direction == ScrollDirection.forward &&
                  isNavigationCompact.value) {
                isNavigationCompact.value = false;
              }
              return false;
            },
            child: PersistentTabView(
              controller: controller,
              backgroundColor: Colors.transparent,
              margin: const EdgeInsets.fromLTRB(24, 0, 24, 12),
              navBarOverlap: const NavBarOverlap.full(),
              screenTransitionAnimation: const ScreenTransitionAnimation.none(),
              tabs: [
                PersistentTabConfig(
                  screen: const CustomerDashboardView(),
                  item: ItemConfig(
                    icon: const Icon(Icons.home_rounded),
                    inactiveIcon: const Icon(Icons.home_outlined),
                    title: context.l10n.home,
                    activeForegroundColor: activeColor,
                    inactiveForegroundColor: inactiveColor,
                    iconSize: 27,
                  ),
                ),
                PersistentTabConfig(
                  screen: const ExploreView(),
                  item: ItemConfig(
                    icon: const Icon(Icons.explore_rounded),
                    inactiveIcon: const Icon(Icons.explore_outlined),
                    title: context.l10n.explore,
                    activeForegroundColor: activeColor,
                    inactiveForegroundColor: inactiveColor,
                    iconSize: 27,
                  ),
                ),
                PersistentTabConfig(
                  screen: const CustomerBookingsView(),
                  item: ItemConfig(
                    icon: const Icon(Icons.calendar_month_rounded),
                    inactiveIcon: const Icon(Icons.calendar_month_outlined),
                    title: context.l10n.bookings,
                    activeForegroundColor: activeColor,
                    inactiveForegroundColor: inactiveColor,
                    iconSize: 27,
                  ),
                ),
                PersistentTabConfig(
                  screen: const SavedView(),
                  item: ItemConfig(
                    icon: const Icon(Icons.favorite_rounded),
                    inactiveIcon: const Icon(Icons.favorite_border_rounded),
                    title: context.l10n.saved,
                    activeForegroundColor: activeColor,
                    inactiveForegroundColor: inactiveColor,
                    iconSize: 27,
                  ),
                ),
                PersistentTabConfig(
                  screen: const CustomerProfileView(),
                  item: ItemConfig(
                    icon: const Icon(Icons.person_rounded),
                    inactiveIcon: const Icon(Icons.person_outline_rounded),
                    title: context.l10n.profile,
                    activeForegroundColor: activeColor,
                    inactiveForegroundColor: inactiveColor,
                    iconSize: 27,
                  ),
                ),
              ],
              onTabChanged: (index) {
                isNavigationCompact.value = false;
                if (index != state.currentTabIndex) {
                  context.read<CustomerHomeBloc>().add(
                    CustomerTabChanged(index),
                  );
                }
              },
              navBarBuilder: (navBarConfig) => InstagramBottomNavigation(
                navBarConfig: navBarConfig,
                isCompact: isNavigationCompact.value,
              ),
            ),
          );
        },
      ),
    );
  }
}
