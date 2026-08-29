import 'package:flutter/material.dart';
import 'package:multibook/src/features/business-side/dashboard/presentation/widgets/dashboard_earnings_legend_item.dart';

class DashboardEarningsLegend extends StatelessWidget {
  const DashboardEarningsLegend({
    required this.totalLabel,
    required this.onlineLabel,
    required this.cashLabel,
    super.key,
  });

  final String totalLabel;
  final String onlineLabel;
  final String cashLabel;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 12,
    runSpacing: 6,
    children: [
      DashboardEarningsLegendItem(
        label: totalLabel,
        color: const Color(0xFF24E5C5),
      ),
      DashboardEarningsLegendItem(
        label: onlineLabel,
        color: const Color(0xFF8B5CF6),
      ),
      DashboardEarningsLegendItem(
        label: cashLabel,
        color: const Color(0xFFF59E0B),
      ),
    ],
  );
}
