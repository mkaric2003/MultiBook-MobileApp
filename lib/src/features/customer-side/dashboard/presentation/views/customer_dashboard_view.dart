import 'package:aquabook/app.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/features/customer-side/create_appointment/domain/models/create_appointment_arguments.dart';
import 'package:aquabook/src/features/customer-side/dashboard/bloc/customer_dashboard_cubit.dart';
import 'package:aquabook/src/features/customer-side/dashboard/bloc/customer_dashboard_state.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_filters.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_filters.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/customer_home_tab_selector.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/customer_home_top_bar.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/destination_search_field.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/services_content.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/stays_content.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/stay_filters/stay_filters_sheet.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/service_filters/service_filters_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomerDashboardView extends StatelessWidget {
  const CustomerDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<CustomerDashboardCubit>();
        cubit.observeUserLocation();
        cubit.loadPopularNearbyStays();
        cubit.loadRecommendedStays();
        cubit.loadStayCities();
        cubit.loadDraft();
        cubit.loadAppointmentDraft();
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
                        hintText: state.selectedTab == CustomerHomeTab.stays
                            ? 'Where to?'
                            : 'Find a service',
                        onTap: () => context.push(
                          AppRoutes.CUSTOMER_SEARCH,
                          extra: state.selectedTab,
                        ),
                        onFilterTap: () async {
                          if (state.selectedTab == CustomerHomeTab.stays) {
                            final filters =
                                await showModalBottomSheet<StayFilters>(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (_) => FractionallySizedBox(
                                    heightFactor: 0.94,
                                    child: StayFiltersSheet(
                                      initialFilters: state.stayFilters,
                                      cities: state.stayCities,
                                    ),
                                  ),
                                );
                            if (context.mounted && filters != null) {
                              await context
                                  .read<CustomerDashboardCubit>()
                                  .applyStayFilters(filters);
                            }
                            return;
                          }
                          final filters =
                              await showModalBottomSheet<ServiceFilters>(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => FractionallySizedBox(
                                  heightFactor: 0.94,
                                  child: ServiceFiltersSheet(
                                    initialFilters: state.serviceFilters,
                                  ),
                                ),
                              );
                          if (context.mounted && filters != null) {
                            await context
                                .read<CustomerDashboardCubit>()
                                .applyServiceFilters(filters);
                          }
                        },
                        hasActiveFilters:
                            state.selectedTab == CustomerHomeTab.stays
                            ? state.stayFilters.hasActiveFilters
                            : state.serviceFilters.hasActiveFilters,
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
                          nearbyStays: state.nearbyStays,
                          isNearbyStaysLoading: state.isNearbyStaysLoading,
                          isLoadingMoreNearbyStays:
                              state.isLoadingMoreNearbyStays,
                          hasMoreNearbyStays: state.hasMoreNearbyStays,
                          onLoadMoreNearbyStays: context
                              .read<CustomerDashboardCubit>()
                              .loadMoreNearbyStays,
                          recommendedStays: state.recommendedStays,
                          isRecommendedStaysLoading:
                              state.isRecommendedStaysLoading,
                          otherStays: state.otherStays,
                          isOtherStaysLoading: state.isOtherStaysLoading,
                          hasMoreOtherStays: state.hasMoreOtherStays,
                          isFiltering: state.stayFilters.hasActiveFilters,
                          stayFilters: state.stayFilters,
                          onLoadMoreStays: context
                              .read<CustomerDashboardCubit>()
                              .loadMoreStays,
                          onStayFiltersChanged: context
                              .read<CustomerDashboardCubit>()
                              .applyStayFilters,
                          bookingDraft: state.bookingDraft,
                        )
                      : ServicesContent(
                          popularServices: state.popularServices,
                          isPopularServicesLoading:
                              state.isPopularServicesLoading,
                          otherServices: state.otherServices,
                          isOtherServicesLoading: state.isOtherServicesLoading,
                          hasMoreOtherServices: state.hasMoreOtherServices,
                          isFiltering: state.serviceFilters.hasActiveFilters,
                          onLoadMoreServices: context
                              .read<CustomerDashboardCubit>()
                              .loadMoreServices,
                          appointmentDraft: state.appointmentDraft,
                          onContinueAppointment: state.appointmentDraft == null
                              ? null
                              : () async {
                                  final draft = state.appointmentDraft!;
                                  final business = await context
                                      .read<CustomerDashboardCubit>()
                                      .getAppointmentDraftBusiness(draft);
                                  if (context.mounted && business != null) {
                                    context.push(
                                      AppRoutes.CREATE_APPOINTMENT,
                                      extra: CreateAppointmentArguments(
                                        business: business,
                                        initialOfferingId:
                                            draft
                                                .selectedOfferingIds
                                                .firstOrNull ??
                                            '',
                                        draft: draft,
                                      ),
                                    );
                                  }
                                },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
