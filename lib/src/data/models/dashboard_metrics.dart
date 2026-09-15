import 'package:dart_mappable/dart_mappable.dart';
import 'package:multibook/src/data/models/dashboard_metrics_month.dart';

part 'dashboard_metrics.mapper.dart';

@MappableClass()
class DashboardMetrics with DashboardMetricsMappable {
  const DashboardMetrics({
    required this.businessId,
    required this.businessType,
    required this.currency,
    required this.activeReservationCount,
    required this.currentMonth,
  });

  final String businessId;
  final String businessType;
  final String currency;
  final int activeReservationCount;
  final DashboardMetricsMonth currentMonth;
}
