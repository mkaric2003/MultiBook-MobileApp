import 'package:aquabook/src/features/customer-side/bookings/presentation/views/customer_bookings_view.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/views/customer_dashboard_view.dart';
import 'package:aquabook/src/features/customer-side/explore/presentation/views/explore_view.dart';
import 'package:aquabook/src/features/customer-side/home/bloc/customer_home_bloc.dart';
import 'package:aquabook/src/features/customer-side/home/bloc/customer_home_event.dart';
import 'package:aquabook/src/features/customer-side/home/bloc/customer_home_state.dart';
import 'package:aquabook/src/features/customer-side/home/presentation/widgets/customer_bottom_navigation.dart';
import 'package:aquabook/src/features/customer-side/profile/presentation/views/customer_profile_view.dart';
import 'package:aquabook/src/features/customer-side/saved/presentation/views/saved_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerHomeView extends StatelessWidget {
  const CustomerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CustomerHomeBloc(),
      child: BlocBuilder<CustomerHomeBloc, CustomerHomeState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.currentTabIndex,
              children: [
                const CustomerDashboardView(),
                const ExploreView(),
                const CustomerBookingsView(),
                SavedView(key: ValueKey(state.currentTabIndex)),
                const CustomerProfileView(),
              ],
            ),
            bottomNavigationBar: CustomerBottomNavigation(
              currentIndex: state.currentTabIndex,
              onTap: (index) => context.read<CustomerHomeBloc>().add(
                CustomerTabChanged(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
