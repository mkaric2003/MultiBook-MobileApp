import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/business-side/dashboard/presentation/widgets/dashboard_chart_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardBookingsChart extends StatelessWidget {
  const DashboardBookingsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardChartCard(
      title: 'Bookings Trend',
      child: BarChart(
        BarChartData(
          maxY: 30,
          alignment: BarChartAlignment.spaceAround,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            drawVerticalLine: false,
            horizontalInterval: 10,
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
                interval: 10,
                getTitlesWidget: (value, meta) => Text(
                  value.toInt().toString(),
                  style: const TextStyle(color: AppColors.muted, fontSize: 13),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  const labels = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      labels[value.toInt()],
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 13,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: 17,
                  color: AppColors.primary,
                  width: 40,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(
                  toY: 22,
                  color: AppColors.primary,
                  width: 40,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(
                  toY: 26,
                  color: AppColors.primary,
                  width: 40,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ],
            ),
            BarChartGroupData(
              x: 3,
              barRods: [
                BarChartRodData(
                  toY: 19,
                  color: AppColors.primary,
                  width: 40,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
