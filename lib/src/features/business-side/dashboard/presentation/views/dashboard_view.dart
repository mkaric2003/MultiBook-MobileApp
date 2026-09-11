import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:multibook/app.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/features/business-side/dashboard/bloc/dashboard_cubit.dart';
import 'package:multibook/src/features/business-side/dashboard/bloc/dashboard_state.dart';
import 'package:multibook/src/features/business-side/dashboard/presentation/widgets/dashboard_bookings_chart.dart';
import 'package:multibook/src/features/business-side/dashboard/presentation/widgets/dashboard_business_header.dart';
import 'package:multibook/src/features/business-side/dashboard/presentation/widgets/dashboard_earnings_chart.dart';
import 'package:multibook/src/features/business-side/dashboard/presentation/widgets/dashboard_empty_state.dart';
import 'package:multibook/src/features/business-side/dashboard/presentation/widgets/dashboard_metric_card.dart';

class DashboardView extends HookWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = useMemoized(() => getIt<DashboardCubit>());
    useEffect(() {
      cubit.initialize();
      return cubit.close;
    }, [cubit]);

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
            bottom: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DashboardBusinessHeader(
                    business: business,
                    onNotificationsPressed: () =>
                        context.push(AppRoutes.NOTIFICATIONS),
                    onSwitchBusiness: () =>
                        context.push(AppRoutes.MY_BUSINESSES),
                  ),
                  const SizedBox(height: 20),
                  DashboardMetricCard(
                    title: business.type == BusinessType.stays
                        ? context.l10n.activeBookings
                        : context.l10n.activeAppointments,
                    value: (state.metrics?.activeReservationCount ?? 0)
                        .toString(),
                    icon: Icons.event_available,
                    iconBackgroundColor: AppColors.primary.withValues(
                      alpha: .18,
                    ),
                  ),
                  const SizedBox(height: 14),
                  DashboardMetricCard(
                    title: context.l10n.earningsThisMonth,
                    value: context.l10n.formatCurrency(
                      state.metrics?.currentMonth.revenue ?? 0,
                    ),
                    valueColor: Color(0xFF24E5C5),
                    icon: Icons.attach_money,
                    iconBackgroundColor: AppColors.success.withValues(
                      alpha: .18,
                    ),
                    iconColor: Color(0xFF24E5C5),
                  ),
                  const SizedBox(height: 14),
                  DashboardMetricCard(
                    title: context.l10n.averageRating,
                    value: business.averageRating.toStringAsFixed(1),
                    icon: Icons.star,
                    iconBackgroundColor: const Color(
                      0xFFF59E0B,
                    ).withValues(alpha: .18),
                    suffix: const Text(
                      '★★★★★',
                      style: TextStyle(color: Color(0xFFFBBF24), fontSize: 18),
                    ),
                    iconColor: Color(0xFFFBBF24),
                  ),
                  const SizedBox(height: 20),
                  DashboardEarningsChart(
                    values: _weeklyValues(
                      state.metrics?.currentMonth.dailyRevenue ?? const {},
                    ),
                  ),
                  const SizedBox(height: 20),
                  DashboardBookingsChart(
                    values: _weeklyValues(
                      state.metrics?.currentMonth.dailyReservations ?? const {},
                    ),
                    title: business.type == BusinessType.stays
                        ? context.l10n.bookingsTrend
                        : context.l10n.appointmentsTrend,
                    tooltipLabel: business.type == BusinessType.stays
                        ? context.l10n.bookings
                        : context.l10n.appointments,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

List<double> _weeklyValues(Map<String, double> dailyValues) {
  final now = DateTime.now();
  final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
  final result = List<double>.filled(4, 0);
  for (final entry in dailyValues.entries) {
    final date = DateTime.tryParse(entry.key);
    if (date == null || date.year != now.year || date.month != now.month) {
      continue;
    }
    final week = (((date.day - 1) * 4) / daysInMonth).floor().clamp(0, 3);
    result[week] += entry.value;
  }
  return result;
}
