import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/data/models/dashboard_metrics.dart';

class DashboardState {
  const DashboardState({this.isLoading = true, this.business, this.metrics});

  final bool isLoading;
  final BusinessModel? business;
  final DashboardMetrics? metrics;

  DashboardState copyWith({
    bool? isLoading,
    BusinessModel? business,
    DashboardMetrics? metrics,
  }) => DashboardState(
    isLoading: isLoading ?? this.isLoading,
    business: business ?? this.business,
    metrics: metrics ?? this.metrics,
  );
}
