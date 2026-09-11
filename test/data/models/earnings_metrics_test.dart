import 'package:flutter_test/flutter_test.dart';
import 'package:multibook/src/data/models/earnings_metrics.dart';

void main() {
  test('maps business and staff earnings values in minor units', () {
    final metrics = EarningsMetricsMapper.fromMap({
      'businessId': 'business-1',
      'businessType': 'service',
      'currency': 'BAM',
      'startDate': '2026-09-01',
      'endDate': '2026-09-06',
      'staffId': 'staff-1',
      'revenueMinor': 33091,
      'reservationCount': 2,
      'onlineRevenueMinor': 23091,
      'cashRevenueMinor': 10000,
      'staffEarningsMinor': 25000,
      'dailyRevenueMinor': {'2026-09-06': 33091},
      'dailyReservationCount': {'2026-09-06': 2},
      'dailyOnlineRevenueMinor': {'2026-09-06': 23091},
      'dailyCashRevenueMinor': {'2026-09-06': 10000},
      'dailyStaffEarningsMinor': {'2026-09-06': 25000},
    });

    expect(metrics.revenueMinor, 33091);
    expect(metrics.staffEarningsMinor, 25000);
    expect(metrics.dailyReservationCount, {'2026-09-06': 2});
  });
}
