import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/api_exception.dart';
import 'package:multibook/src/core/errors/rest_repository_executor.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/data_sources/dashboard_metrics_api_data_source.dart';
import 'package:multibook/src/data/models/dashboard_metrics.dart';
import 'package:multibook/src/domain/repositories/dashboard_metrics_repository.dart';

@LazySingleton(as: DashboardMetricsRepository)
class DashboardMetricsRepositoryImpl implements DashboardMetricsRepository {
  DashboardMetricsRepositoryImpl(this._source, this._executor);

  final DashboardMetricsApiDataSource _source;
  final RestRepositoryExecutor _executor;

  @override
  Stream<Result<DashboardMetrics>> watchDashboardMetrics(
    String businessId,
  ) async* {
    try {
      await for (final metrics in _source.watchDashboardMetrics(businessId)) {
        yield Success(metrics);
      }
    } on ApiException catch (error) {
      yield FailureResult(_executor.mapFailure(error));
    } catch (_) {
      yield const FailureResult(UnknownFailure());
    }
  }
}
