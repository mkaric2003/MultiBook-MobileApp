import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/earnings_metrics.dart';
import 'package:multibook/src/domain/repositories/earnings_metrics_repository.dart';

@injectable
class WatchEarningsMetricsUseCase {
  WatchEarningsMetricsUseCase(this._repository);

  final EarningsMetricsRepository _repository;

  Stream<Result<EarningsMetrics>> execute({
    required String businessId,
    required DateTime startDate,
    required DateTime endDate,
    String? staffId,
  }) => _repository.watchEarningsMetrics(
    businessId: businessId,
    startDate: startDate,
    endDate: endDate,
    staffId: staffId,
  );
}
