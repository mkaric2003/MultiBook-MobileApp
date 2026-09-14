import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/features/business-side/dashboard/presentation/widgets/dashboard_chart_card.dart';
import 'package:multibook/src/features/business-side/dashboard/presentation/widgets/dashboard_earnings_legend.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardEarningsChart extends StatelessWidget {
  const DashboardEarningsChart({
    required this.values,
    this.onlineValues,
    this.cashValues,
    super.key,
  });

  final List<double> values;
  final List<double>? onlineValues;
  final List<double>? cashValues;

  bool get _showsPaymentBreakdown => onlineValues != null && cashValues != null;

  @override
  Widget build(BuildContext context) {
    return DashboardChartCard(
      title: context.l10n.earningsTrend,
      child: Column(
        children: [
          if (_showsPaymentBreakdown) ...[
            DashboardEarningsLegend(
              totalLabel: context.l10n.total,
              onlineLabel: context.l10n.onlineEarnings,
              cashLabel: context.l10n.cashEarnings,
            ),
            const SizedBox(height: 8),
          ],
          Expanded(
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 3,
                minY: 0,
                maxY: _maximumValue,
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => context.appPalette.surface,
                    tooltipBorderRadius: BorderRadius.circular(8),
                    fitInsideHorizontally: true,
                    fitInsideVertically: true,
                    getTooltipItems: (touchedSpots) => touchedSpots.map((spot) {
                      final label = switch (spot.barIndex) {
                        0 => context.l10n.total,
                        1 => context.l10n.onlineEarnings,
                        _ => context.l10n.cashEarnings,
                      };
                      return LineTooltipItem(
                        _showsPaymentBreakdown
                            ? '$label\n${context.l10n.formatCurrency(spot.y)}'
                            : context.l10n.formatCurrency(spot.y),
                        TextStyle(
                          color: context.appPalette.foreground,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  drawVerticalLine: false,
                  horizontalInterval: _maximumValue / 4,
                  getDrawingHorizontalLine: (_) =>
                      FlLine(color: context.appPalette.border, strokeWidth: 1),
                ),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 42,
                      interval: _maximumValue / 4,
                      getTitlesWidget: (value, meta) => Text(
                        context.l10n.formatCurrency(value),
                        style: TextStyle(
                          color: context.appPalette.muted,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 25,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            context.l10n.week(value.toInt() + 1),
                            style: TextStyle(
                              color: context.appPalette.muted,
                              fontSize: 11,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(
                      4,
                      (index) => FlSpot(index.toDouble(), values[index]),
                    ),
                    color: AppColors.earningsTotal,
                    barWidth: 3,
                    isCurved: false,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(show: false),
                  ),
                  if (_showsPaymentBreakdown)
                    LineChartBarData(
                      spots: List.generate(
                        4,
                        (index) =>
                            FlSpot(index.toDouble(), onlineValues![index]),
                      ),
                      color: AppColors.earningsOnline,
                      barWidth: 2,
                      isCurved: false,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                    ),
                  if (_showsPaymentBreakdown)
                    LineChartBarData(
                      spots: List.generate(
                        4,
                        (index) => FlSpot(index.toDouble(), cashValues![index]),
                      ),
                      color: AppColors.earningsCash,
                      barWidth: 2,
                      isCurved: false,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double get _maximumValue {
    final chartValues = [
      ...values,
      if (_showsPaymentBreakdown) ...onlineValues!,
      if (_showsPaymentBreakdown) ...cashValues!,
    ];
    final maximum = chartValues.fold<double>(
      0,
      (value, item) => item > value ? item : value,
    );
    return maximum == 0 ? 100 : (maximum * 1.2).ceilToDouble();
  }
}
