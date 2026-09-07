import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/earnings_metrics.dart';

abstract class EarningsMetricsRepository {
  Stream<Result<EarningsMetrics>> watchEarningsMetrics({
    required String businessId,
    required DateTime startDate,
    required DateTime endDate,
    String? staffId,
  });
}
