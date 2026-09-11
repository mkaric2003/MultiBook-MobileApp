import 'package:dart_mappable/dart_mappable.dart';

part 'dashboard_metrics_month.mapper.dart';

@MappableClass()
class DashboardMetricsMonth with DashboardMetricsMonthMappable {
  const DashboardMetricsMonth({
    required this.monthKey,
    required this.revenueMinor,
    required this.reservationCount,
    required this.dailyRevenueMinor,
    required this.dailyReservationCount,
  });

  final String monthKey;
  final int revenueMinor;
  final int reservationCount;
  final Map<String, int> dailyRevenueMinor;
  final Map<String, int> dailyReservationCount;

  // Currency formatting across the app expects amounts in minor units and
  // performs the decimal conversion itself.
  double get revenue => revenueMinor.toDouble();

  Map<String, double> get dailyRevenue =>
      dailyRevenueMinor.map((day, value) => MapEntry(day, value.toDouble()));

  Map<String, double> get dailyReservations => dailyReservationCount.map(
    (day, value) => MapEntry(day, value.toDouble()),
  );
}
