import 'package:aquabook/app.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/data/repositories/user_repository.dart';
import 'package:aquabook/src/features/business-side/dashboard/bloc/dashboard_cubit.dart';
import 'package:aquabook/src/features/business-side/dashboard/bloc/dashboard_state.dart';
import 'package:aquabook/src/features/business-side/dashboard/presentation/widgets/dashboard_bookings_chart.dart';
import 'package:aquabook/src/features/business-side/dashboard/presentation/widgets/dashboard_business_header.dart';
import 'package:aquabook/src/features/business-side/dashboard/presentation/widgets/dashboard_earnings_chart.dart';
import 'package:aquabook/src/features/business-side/dashboard/presentation/widgets/dashboard_empty_state.dart';
import 'package:aquabook/src/features/business-side/dashboard/presentation/widgets/dashboard_metric_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class DashboardView extends HookWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = useMemoized(() => getIt<DashboardCubit>());
    final selectedBusinessId = useValueListenable(
      getIt<UserRepository>().selectedBusinessId,
    );
    useEffect(() {
      cubit.load();
      return null;
    }, [cubit, selectedBusinessId]);
    useEffect(() => cubit.close, [cubit]);

    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final business = state.business;
          if (business == null) {
            return DashboardEmptyState(
              onAddBusiness: () => context.push(AppRoutes.ADD_BUSINESS),
            );
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DashboardBusinessHeader(
                    business: business,
                    onNotificationsPressed: () =>
                        context.push(AppRoutes.NOTIFICATIONS),
                    onSwitchBusiness: () async {
                      await context.push(AppRoutes.MY_BUSINESSES);
                      if (context.mounted) {
                        await context.read<DashboardCubit>().load();
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  const DashboardMetricCard(
                    title: 'Active Bookings',
                    value: '24',
                    icon: Icons.event_available,
                    iconBackgroundColor: Color(0xFF3F315E),
                  ),
                  const SizedBox(height: 14),
                  const DashboardMetricCard(
                    title: 'Earnings This Month',
                    value: '\$12,450',
                    valueColor: Color(0xFF24E5C5),
                    icon: Icons.attach_money,
                    iconBackgroundColor: Color(0xFF164A4A),
                    iconColor: Color(0xFF24E5C5),
                  ),
                  const SizedBox(height: 14),
                  DashboardMetricCard(
                    title: 'Average Rating',
                    value: '4.8',
                    icon: Icons.star,
                    iconBackgroundColor: const Color(0xFF55472A),
                    suffix: const Text(
                      '★★★★★',
                      style: TextStyle(color: Color(0xFFFBBF24), fontSize: 18),
                    ),
                    iconColor: Color(0xFFFBBF24),
                  ),
                  const SizedBox(height: 20),
                  const DashboardEarningsChart(),
                  const SizedBox(height: 20),
                  const DashboardBookingsChart(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
