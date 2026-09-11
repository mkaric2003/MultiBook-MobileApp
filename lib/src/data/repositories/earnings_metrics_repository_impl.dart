import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/api_exception.dart';
import 'package:multibook/src/core/errors/rest_repository_executor.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/data_sources/earnings_metrics_api_data_source.dart';
import 'package:multibook/src/data/models/earnings_metrics.dart';
import 'package:multibook/src/domain/repositories/earnings_metrics_repository.dart';

@LazySingleton(as: EarningsMetricsRepository)
class EarningsMetricsRepositoryImpl implements EarningsMetricsRepository {
  EarningsMetricsRepositoryImpl(this._source, this._executor);

  final EarningsMetricsApiDataSource _source;
  final RestRepositoryExecutor _executor;

  @override
  Stream<Result<EarningsMetrics>> watchEarningsMetrics({
    required String businessId,
    required DateTime startDate,
    required DateTime endDate,
    String? staffId,
  }) async* {
    try {
      await for (final metrics in _source.watchEarningsMetrics(
        businessId: businessId,
        startDate: startDate,
        endDate: endDate,
        staffId: staffId,
      )) {
        yield Success(metrics);
      }
    } on ApiException catch (error) {
      yield FailureResult(_executor.mapFailure(error));
    } catch (_) {
      yield const FailureResult(UnknownFailure());
    }
  }
}
