import 'package:dart_mappable/dart_mappable.dart';

part 'earnings_metrics.mapper.dart';

@MappableClass()
class EarningsMetrics with EarningsMetricsMappable {
  const EarningsMetrics({
    required this.businessId,
    required this.businessType,
    required this.currency,
    required this.startDate,
    required this.endDate,
    required this.revenueMinor,
    required this.reservationCount,
    required this.onlineRevenueMinor,
    required this.cashRevenueMinor,
    required this.staffEarningsMinor,
    required this.dailyRevenueMinor,
    required this.dailyReservationCount,
    required this.dailyOnlineRevenueMinor,
    required this.dailyCashRevenueMinor,
    required this.dailyStaffEarningsMinor,
    this.staffId,
  });

  final String businessId;
  final String businessType;
  final String currency;
  final String startDate;
  final String endDate;
  final String? staffId;
  final int revenueMinor;
  final int reservationCount;
  final int onlineRevenueMinor;
  final int cashRevenueMinor;
  final int staffEarningsMinor;
  final Map<String, int> dailyRevenueMinor;
  final Map<String, int> dailyReservationCount;
  final Map<String, int> dailyOnlineRevenueMinor;
  final Map<String, int> dailyCashRevenueMinor;
  final Map<String, int> dailyStaffEarningsMinor;
}
