import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/features/business-side/dashboard/domain/models/business_metrics.dart';
import 'package:multibook/src/features/business-side/dashboard/domain/models/business_monthly_metrics.dart';

class DashboardState {
  const DashboardState({
    this.isLoading = true,
    this.business,
    this.metrics = const BusinessMetrics(),
    this.monthlyMetrics = const BusinessMonthlyMetrics(),
  });

  final bool isLoading;
  final BusinessModel? business;
  final BusinessMetrics metrics;
  final BusinessMonthlyMetrics monthlyMetrics;

  DashboardState copyWith({
    bool? isLoading,
    BusinessModel? business,
    BusinessMetrics? metrics,
    BusinessMonthlyMetrics? monthlyMetrics,
  }) => DashboardState(
    isLoading: isLoading ?? this.isLoading,
    business: business ?? this.business,
    metrics: metrics ?? this.metrics,
    monthlyMetrics: monthlyMetrics ?? this.monthlyMetrics,
  );
}
