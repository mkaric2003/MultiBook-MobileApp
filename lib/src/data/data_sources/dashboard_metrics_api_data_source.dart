import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/networking/sse_client.dart';
import 'package:multibook/src/data/models/dashboard_metrics.dart';

@lazySingleton
class DashboardMetricsApiDataSource {
  DashboardMetricsApiDataSource(this._sseClient);

  final SseClient _sseClient;

  Stream<DashboardMetrics> watchDashboardMetrics(String businessId) =>
      _sseClient.watch(
        path: '/v1/businesses/$businessId/dashboard-metrics/stream',
        eventName: 'dashboard_metrics',
        decode: DashboardMetricsMapper.fromJson,
      );
}
