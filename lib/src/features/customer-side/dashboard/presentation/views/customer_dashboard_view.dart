import 'package:aquabook/app.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/features/customer-side/dashboard/bloc/customer_dashboard_cubit.dart';
import 'package:aquabook/src/features/customer-side/dashboard/bloc/customer_dashboard_state.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/customer_home_tab_selector.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/customer_home_top_bar.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/destination_search_field.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/stays_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomerDashboardView extends StatelessWidget {
  const CustomerDashboardView({super.key});

  static const _nearbyStays = [
    StayListing(
      id: 'city-center-hotel',
      name: 'City Center Hotel',
      rating: 4.8,
      reviewCount: 124,
      pricePerNight: 180,
      location: '',
      imageUrl:
          'https://images.unsplash.com/photo-1564501049412-61c2a3083791?auto=format&fit=crop&w=700&q=85',
    ),
    StayListing(
      id: 'downtown-loft',
      name: 'Downtown Loft',
      rating: 4.6,
      reviewCount: 89,
      pricePerNight: 145,
      location: '',
      imageUrl:
          'https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?auto=format&fit=crop&w=700&q=85',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<CustomerDashboardCubit>();
        cubit.loadRecommendedStays();
        cubit.loadDraft();
        return cubit;
      },
      child: BlocBuilder<CustomerDashboardCubit, CustomerDashboardState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                  child: Column(
                    children: [
                      const CustomerHomeTopBar(),
                      const SizedBox(height: 28),
                      DestinationSearchField(
                        onTap: () => context.push(AppRoutes.CUSTOMER_SEARCH),
                      ),
                      const SizedBox(height: 16),
                      CustomerHomeTabSelector(
                        selectedTab: state.selectedTab,
                        onChanged: context
                            .read<CustomerDashboardCubit>()
                            .selectTab,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: state.selectedTab == CustomerHomeTab.stays
                      ? StaysContent(
                          nearbyStays: _nearbyStays,
                          recommendedStays: state.recommendedStays,
                          isRecommendedStaysLoading:
                              state.isRecommendedStaysLoading,
                          otherStays: state.otherStays,
                          isOtherStaysLoading: state.isOtherStaysLoading,
                          hasMoreOtherStays: state.hasMoreOtherStays,
                          onLoadMoreStays: context
                              .read<CustomerDashboardCubit>()
                              .loadMoreStays,
                          bookingDraft: state.bookingDraft,
                        )
                      : const Center(child: Text('Services coming soon')),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
