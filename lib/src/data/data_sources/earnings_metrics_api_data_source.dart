import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/networking/sse_client.dart';
import 'package:multibook/src/data/models/earnings_metrics.dart';

@lazySingleton
class EarningsMetricsApiDataSource {
  EarningsMetricsApiDataSource(this._sseClient);

  final SseClient _sseClient;

  Stream<EarningsMetrics> watchEarningsMetrics({
    required String businessId,
    required DateTime startDate,
    required DateTime endDate,
    String? staffId,
  }) => _sseClient.watch(
    path: Uri(
      path: '/v1/businesses/$businessId/earnings/stream',
      queryParameters: {
        'startDate': _dateKey(startDate),
        'endDate': _dateKey(endDate),
        'utcOffsetMinutes': DateTime.now().timeZoneOffset.inMinutes.toString(),
        if (staffId != null) 'staffId': staffId,
      },
    ).toString(),
    eventName: 'earnings_metrics',
    decode: EarningsMetricsMapper.fromJson,
  );

  String _dateKey(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}
