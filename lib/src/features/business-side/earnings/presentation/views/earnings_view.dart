import 'package:aquabook/app.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/business-side/dashboard/presentation/widgets/dashboard_bookings_chart.dart';
import 'package:aquabook/src/features/business-side/dashboard/presentation/widgets/dashboard_earnings_chart.dart';
import 'package:aquabook/src/features/business-side/dashboard/presentation/widgets/dashboard_empty_state.dart';
import 'package:aquabook/src/features/business-side/earnings/bloc/earnings_cubit.dart';
import 'package:aquabook/src/features/business-side/earnings/bloc/earnings_state.dart';
import 'package:aquabook/src/features/business-side/earnings/presentation/widgets/earnings_business_selector.dart';
import 'package:aquabook/src/features/business-side/earnings/presentation/widgets/earnings_payout_card.dart';
import 'package:aquabook/src/features/business-side/earnings/presentation/widgets/earnings_summary_card.dart';
import 'package:aquabook/src/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class EarningsView extends HookWidget {
  const EarningsView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = useMemoized(() => getIt<EarningsCubit>());
    useEffect(() {
      cubit.load();
      return null;
    }, [cubit]);
    useEffect(() => cubit.close, [cubit]);

    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<EarningsCubit, EarningsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.selectedBusiness == null) {
            return DashboardEmptyState(
              onAddBusiness: () => context.push(AppRoutes.ADD_BUSINESS),
            );
          }

          final metrics = state.monthlyMetrics;
          return SafeArea(
            bottom: false,
            child: Column(
              children: [
                CustomAppBar(
                  title: context.l10n.earnings,
                  showBackButton: false,
                  trailing: EarningsBusinessSelector(
                    businesses: state.businesses,
                    selectedBusiness: state.selectedBusiness,
                    onSelected: context.read<EarningsCubit>().selectBusiness,
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                    children: [
                      if (state.hasError) ...[
                        Text(
                          context.l10n.earningsLoadFailed,
                          style: const TextStyle(
                            color: AppColors.muted,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                      EarningsSummaryCard(
                        title: context.l10n.totalEarningsThisMonth,
                        value: context.l10n.formatCurrency(metrics.revenue),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: EarningsPayoutCard(
                              title: context.l10n.onlineEarnings,
                              value: context.l10n.formatCurrency(
                                metrics.onlineEarnings,
                              ),
                              valueColor: const Color(0xFFF59E0B),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: EarningsPayoutCard(
                              title: context.l10n.cashEarnings,
                              value: context.l10n.formatCurrency(
                                metrics.cashEarnings,
                              ),
                              valueColor: AppColors.success,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      DashboardEarningsChart(
                        values: _weeklyValues(metrics.dailyRevenue),
                      ),
                      const SizedBox(height: 20),
                      DashboardBookingsChart(
                        values: _weeklyValues(metrics.dailyBookings),
                        title: context.l10n.bookingsTrend,
                        tooltipLabel: context.l10n.bookings,
                      ),
                    ],
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
