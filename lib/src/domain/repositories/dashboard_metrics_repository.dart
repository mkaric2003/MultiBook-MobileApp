import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/dashboard_metrics.dart';

abstract class DashboardMetricsRepository {
  Stream<Result<DashboardMetrics>> watchDashboardMetrics(String businessId);
}
