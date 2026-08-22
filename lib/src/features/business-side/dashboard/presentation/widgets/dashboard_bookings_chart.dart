import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/features/business-side/dashboard/presentation/widgets/dashboard_chart_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardBookingsChart extends StatelessWidget {
  const DashboardBookingsChart({
    required this.values,
    required this.title,
    required this.tooltipLabel,
    super.key,
  });

  final List<double> values;
  final String title;
  final String tooltipLabel;

  @override
  Widget build(BuildContext context) {
    return DashboardChartCard(
      title: title,
      child: BarChart(
        BarChartData(
          maxY: _maximumValue,
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => AppColors.surface,
              tooltipBorderRadius: BorderRadius.circular(8),
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              getTooltipItem: (group, groupIndex, rod, rodIndex) =>
                  BarTooltipItem(
                    '${rod.toY.toInt()} $tooltipLabel',
                    const TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            drawVerticalLine: false,
            horizontalInterval: _maximumValue / 3,
            getDrawingHorizontalLine: (_) =>
                const FlLine(color: AppColors.border, strokeWidth: 1),
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
                reservedSize: 30,
                interval: _maximumValue / 3,
                getTitlesWidget: (value, meta) => Text(
                  value.toInt().toString(),
                  style: const TextStyle(color: AppColors.muted, fontSize: 11),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 25,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      context.l10n.week(value.toInt() + 1),
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 11,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(
            4,
            (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: values[index],
                  color: AppColors.primary,
                  width: 30,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double get _maximumValue {
    final maximum = values.fold<double>(
      0,
      (value, item) => item > value ? item : value,
    );
    return maximum == 0 ? 1 : (maximum * 1.2).ceilToDouble();
  }
}
