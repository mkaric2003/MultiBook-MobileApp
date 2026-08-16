import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/business-side/dashboard/presentation/widgets/dashboard_chart_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardEarningsChart extends StatelessWidget {
  const DashboardEarningsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardChartCard(
      title: 'Earnings Trend',
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 3,
          minY: 2500,
          maxY: 4000,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            drawVerticalLine: false,
            horizontalInterval: 500,
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
                reservedSize: 42,
                interval: 500,
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
                interval: 1,
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
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 2800),
                FlSpot(1, 3200),
                FlSpot(2, 3800),
                FlSpot(3, 2650),
              ],
              color: const Color(0xFF24E5C5),
              barWidth: 3,
              isCurved: false,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
