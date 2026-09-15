import 'package:flutter/material.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
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
        color: AppColors.earningsTotal,
      ),
      DashboardEarningsLegendItem(
        label: onlineLabel,
        color: AppColors.earningsOnline,
      ),
      DashboardEarningsLegendItem(
        label: cashLabel,
        color: AppColors.earningsCash,
      ),
    ],
  );
}
