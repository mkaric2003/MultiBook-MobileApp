import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/dashboard_metrics.dart';
import 'package:multibook/src/domain/repositories/dashboard_metrics_repository.dart';

@injectable
class WatchDashboardMetricsUseCase {
  WatchDashboardMetricsUseCase(this._repository);

  final DashboardMetricsRepository _repository;

  Stream<Result<DashboardMetrics>> execute(String businessId) =>
      _repository.watchDashboardMetrics(businessId);
}
