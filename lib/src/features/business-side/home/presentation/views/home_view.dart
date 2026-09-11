import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:multibook/app.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/business-side/bookings/presentation/views/bookings_view.dart';
import 'package:multibook/src/features/business-side/dashboard/presentation/views/dashboard_view.dart';
import 'package:multibook/src/features/business-side/earnings/presentation/views/earnings_view.dart';
import 'package:multibook/src/features/business-side/home/bloc/home_bloc.dart';
import 'package:multibook/src/features/business-side/home/bloc/home_event.dart';
import 'package:multibook/src/features/business-side/home/bloc/home_state.dart';
import 'package:multibook/src/features/business-side/more/presentation/views/more_view.dart';
import 'package:multibook/src/global_widgets/instagram_bottom_navigation.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class HomeView extends HookWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(PersistentTabController.new);
    final isNavigationCompact = useState(false);
    useEffect(() => controller.dispose, [controller]);

    return BlocProvider(
      create: (_) => getIt<HomeBloc>(),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (controller.index != state.currentTabIndex) {
            controller.jumpToTab(state.currentTabIndex);
          }
          if (state.isLoading && state.errorMessage == null) {
            context.go(AppRoutes.SIGNIN);
            return;
          }

          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
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
                  screen: const DashboardView(),
                  item: ItemConfig(
                    icon: const Icon(Icons.home_rounded),
                    inactiveIcon: const Icon(Icons.home_outlined),
                    title: 'Dashboard',
                    activeForegroundColor: activeColor,
                    inactiveForegroundColor: inactiveColor,
                    iconSize: 26,
                  ),
                ),
                PersistentTabConfig(
                  screen: const BookingsView(),
                  item: ItemConfig(
                    icon: const Icon(Icons.calendar_month_rounded),
                    inactiveIcon: const Icon(Icons.calendar_month_outlined),
                    title: context.l10n.bookings,
                    activeForegroundColor: activeColor,
                    inactiveForegroundColor: inactiveColor,
                    iconSize: 26,
                  ),
                ),
                PersistentTabConfig(
                  screen: const EarningsView(),
                  item: ItemConfig(
                    icon: const Icon(Icons.account_balance_wallet_rounded),
                    inactiveIcon: const Icon(
                      Icons.account_balance_wallet_outlined,
                    ),
                    title: context.l10n.earnings,
                    activeForegroundColor: activeColor,
                    inactiveForegroundColor: inactiveColor,
                    iconSize: 26,
                  ),
                ),
                PersistentTabConfig(
                  screen: MoreView(
                    onLogout: state.isLoading
                        ? () {}
                        : () => context.read<HomeBloc>().add(
                            const LogoutRequested(),
                          ),
                  ),
                  item: ItemConfig(
                    icon: const Icon(Icons.menu_rounded),
                    title: 'More',
                    activeForegroundColor: activeColor,
                    inactiveForegroundColor: inactiveColor,
                    iconSize: 26,
                  ),
                ),
              ],
              onTabChanged: (index) {
                isNavigationCompact.value = false;
                if (index != state.currentTabIndex) {
                  context.read<HomeBloc>().add(UpdateTabIndex(index));
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
