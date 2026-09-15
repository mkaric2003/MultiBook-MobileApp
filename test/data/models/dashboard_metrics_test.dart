import 'package:flutter_test/flutter_test.dart';
import 'package:multibook/src/data/models/dashboard_metrics.dart';

void main() {
  test('maps dashboard API values and preserves minor units for formatting', () {
    final metrics = DashboardMetricsMapper.fromMap({
      'businessId': 'business-1',
      'businessType': 'stay',
      'currency': 'BAM',
      'activeReservationCount': 3,
      'currentMonth': {
        'monthKey': '2026-09',
        'revenueMinor': 12345,
        'reservationCount': 2,
        'dailyRevenueMinor': {'2026-09-06': 12345},
        'dailyReservationCount': {'2026-09-06': 2},
      },
    });

    expect(metrics.activeReservationCount, 3);
    expect(metrics.currentMonth.revenue, 12345.0);
    expect(metrics.currentMonth.dailyRevenue, {'2026-09-06': 12345.0});
    expect(metrics.currentMonth.dailyReservations, {'2026-09-06': 2.0});
  });
}
