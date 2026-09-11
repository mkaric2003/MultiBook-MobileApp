import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:multibook/app.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/features/business-side/bookings/presentation/views/bookings_view.dart';
import 'package:multibook/src/features/business-side/dashboard/presentation/views/dashboard_view.dart';
import 'package:multibook/src/features/business-side/earnings/presentation/views/earnings_view.dart';
import 'package:multibook/src/features/business-side/home/bloc/home_bloc.dart';
import 'package:multibook/src/features/business-side/home/bloc/home_event.dart';
import 'package:multibook/src/features/business-side/home/bloc/home_state.dart';
import 'package:multibook/src/features/business-side/home/presentation/widgets/client_bottom_navigation.dart';
import 'package:multibook/src/features/business-side/more/presentation/views/more_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeBloc>(),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
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
          return Scaffold(
            body: IndexedStack(
              index: state.currentTabIndex,
              children: [
                const DashboardView(),
                const BookingsView(),
                const EarningsView(),
                MoreView(
                  onLogout: state.isLoading
                      ? () {}
                      : () => context.read<HomeBloc>().add(
                          const LogoutRequested(),
                        ),
                ),
              ],
            ),
            bottomNavigationBar: ClientBottomNavigation(
              currentIndex: state.currentTabIndex,
              onTap: (index) =>
                  context.read<HomeBloc>().add(UpdateTabIndex(index)),
            ),
          );
        },
      ),
    );
  }
}
