import 'package:multibook/app.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/models/service_provider_model.dart';
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart';
import 'package:multibook/src/features/business-side/dashboard/presentation/widgets/dashboard_bookings_chart.dart';
import 'package:multibook/src/features/business-side/dashboard/presentation/widgets/dashboard_earnings_chart.dart';
import 'package:multibook/src/features/business-side/dashboard/presentation/widgets/dashboard_empty_state.dart';
import 'package:multibook/src/features/business-side/earnings/bloc/earnings_cubit.dart';
import 'package:multibook/src/features/business-side/earnings/bloc/earnings_state.dart';
import 'package:multibook/src/features/business-side/earnings/domain/enums/earnings_period.dart';
import 'package:multibook/src/features/business-side/earnings/domain/models/earnings_date_range.dart';
import 'package:multibook/src/features/business-side/earnings/presentation/widgets/earnings_business_selector.dart';
import 'package:multibook/src/features/business-side/earnings/presentation/widgets/earnings_custom_range_picker_sheet.dart';
import 'package:multibook/src/features/business-side/earnings/presentation/widgets/earnings_payout_card.dart';
import 'package:multibook/src/features/business-side/earnings/presentation/widgets/earnings_period_selector.dart';
import 'package:multibook/src/features/business-side/earnings/presentation/widgets/earnings_provider_selector.dart';
import 'package:multibook/src/features/business-side/earnings/presentation/widgets/earnings_summary_card.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class EarningsView extends HookWidget {
  const EarningsView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = useMemoized(() => getIt<EarningsCubit>());
    final selectedBusinessId = useValueListenable(
      getIt<UserProfileUseCase>().selectedBusinessId,
    );
    useEffect(() {
      cubit.load(businessId: selectedBusinessId);
      return null;
    }, [cubit, selectedBusinessId]);
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
          final range = state.dateRange;
          final List<ServiceProviderModel> providers =
              state.selectedBusiness!.type == BusinessType.services
              ? state.selectedBusiness!.serviceDetails?.availableProviders ??
                    const []
              : const [];
          final isProviderFilterActive = state.selectedProvider != null;
          final grossEarnings = isProviderFilterActive
              ? state.providerMetrics.grossRevenue
              : metrics.revenue;
          final chartRevenue = isProviderFilterActive
              ? state.providerMetrics.dailyGrossRevenue
              : metrics.dailyRevenue;
          final chartBookings = isProviderFilterActive
              ? state.providerMetrics.dailyAppointments
              : metrics.dailyBookings;
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
                      EarningsPeriodSelector(
                        period: state.period,
                        onSelected: (period) async {
                          final cubit = context.read<EarningsCubit>();
                          if (period != EarningsPeriod.custom) {
                            await cubit.selectPeriod(period);
                            return;
                          }
                          final initialRange =
                              range ??
                              EarningsDateRange(
                                start: DateTime.now(),
                                end: DateTime.now(),
                              );
                          final customRange =
                              await showModalBottomSheet<EarningsDateRange>(
                                context: context,
                                isScrollControlled: true,
                                builder: (_) => EarningsCustomRangePickerSheet(
                                  initialRange: initialRange,
                                ),
                              );
                          if (customRange != null && context.mounted) {
                            await cubit.selectPeriod(
                              EarningsPeriod.custom,
                              customRange: customRange,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 14),
                      if (providers.isNotEmpty) ...[
                        EarningsProviderSelector(
                          providers: providers,
                          selectedProvider: state.selectedProvider,
                          onSelected: context
                              .read<EarningsCubit>()
                              .selectProvider,
                        ),
                        const SizedBox(height: 14),
                      ],
                      EarningsSummaryCard(
                        title:
                            '${context.l10n.earningsPeriod}: ${_periodLabel(context, state.period)}',
                        value: context.l10n.formatCurrency(grossEarnings),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: EarningsPayoutCard(
                              title: isProviderFilterActive
                                  ? context.l10n.grossEarnings
                                  : context.l10n.onlineEarnings,
                              value: context.l10n.formatCurrency(
                                isProviderFilterActive
                                    ? grossEarnings
                                    : metrics.onlineEarnings,
                              ),
                              valueColor: const Color(0xFFF59E0B),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: EarningsPayoutCard(
                              title: isProviderFilterActive
                                  ? context.l10n.providerEarnings
                                  : context.l10n.cashEarnings,
                              value: context.l10n.formatCurrency(
                                isProviderFilterActive
                                    ? state.providerMetrics.providerEarnings
                                    : metrics.cashEarnings,
                              ),
                              valueColor: AppColors.success,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      DashboardEarningsChart(
                        values: _periodValues(chartRevenue, range),
                        onlineValues: isProviderFilterActive
                            ? null
                            : _periodValues(metrics.dailyOnlineEarnings, range),
                        cashValues: isProviderFilterActive
                            ? null
                            : _periodValues(metrics.dailyCashEarnings, range),
                      ),
                      const SizedBox(height: 20),
                      DashboardBookingsChart(
                        values: _periodValues(chartBookings, range),
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

List<double> _periodValues(
  Map<String, double> dailyValues,
  EarningsDateRange? range,
) {
  if (range == null) return List<double>.filled(4, 0);
  final isCalendarMonth =
      range.start.day == 1 &&
      range.start.year == range.end.year &&
      range.start.month == range.end.month;
  final bucketDays = isCalendarMonth
      ? DateTime(range.start.year, range.start.month + 1, 0).day
      : range.end.difference(range.start).inDays + 1;
  final result = List<double>.filled(4, 0);
  for (final entry in dailyValues.entries) {
    final date = DateTime.tryParse(entry.key);
    if (date == null || date.isBefore(range.start) || date.isAfter(range.end)) {
      continue;
    }
    final dayOffset = isCalendarMonth
        ? date.day - 1
        : date.difference(range.start).inDays;
    final index = ((dayOffset * 4) / bucketDays).floor().clamp(0, 3);
    result[index] += entry.value;
  }
  return result;
}

String _periodLabel(BuildContext context, EarningsPeriod period) =>
    switch (period) {
      EarningsPeriod.currentWeek => context.l10n.currentWeek,
      EarningsPeriod.previousWeek => context.l10n.previousWeek,
      EarningsPeriod.currentMonth => context.l10n.currentMonth,
      EarningsPeriod.previousMonth => context.l10n.previousMonth,
      EarningsPeriod.currentYear => context.l10n.currentYear,
      EarningsPeriod.previousYear => context.l10n.previousYear,
      EarningsPeriod.custom => context.l10n.customRange,
    };
