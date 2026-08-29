import 'package:multibook/src/data/data_sources/business_metrics_data_source.dart';
import 'package:multibook/src/features/business-side/dashboard/domain/models/business_metrics.dart';
import 'package:multibook/src/features/business-side/dashboard/domain/models/business_monthly_metrics.dart';
import 'package:multibook/src/features/business-side/earnings/domain/models/provider_earnings_metrics.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class BusinessMetricsRepository {
  BusinessMetricsRepository(this._dataSource);

  final BusinessMetricsDataSource _dataSource;

  Future<void> initialize(String businessId) =>
      _dataSource.initialize(businessId);

  Stream<BusinessMetrics> watchSummary(String businessId) =>
      _dataSource.watchSummary(businessId).map(BusinessMetrics.fromJson);

  Stream<BusinessMonthlyMetrics> watchCurrentMonth(String businessId) =>
      _dataSource
          .watchMonth(
            businessId: businessId,
            monthKey: _monthKey(DateTime.now()),
          )
          .map(BusinessMonthlyMetrics.fromJson);

  Stream<BusinessMonthlyMetrics> watchDateRange({
    required String businessId,
    required DateTime start,
    required DateTime end,
  }) {
    final rangeStart = _dateOnly(start);
    final rangeEnd = _dateOnly(end);
    return _dataSource
        .watchMonths(
          businessId: businessId,
          startMonthKey: _monthKey(rangeStart),
          endMonthKey: _monthKey(rangeEnd),
        )
        .map(
          (months) => _aggregateDateRange(
            months.map(BusinessMonthlyMetrics.fromJson),
            start: rangeStart,
            end: rangeEnd,
          ),
        );
  }

  Stream<ProviderEarningsMetrics> watchProviderDateRange({
    required String businessId,
    required String providerId,
    required DateTime start,
    required DateTime end,
  }) {
    final rangeStart = _dateOnly(start);
    final rangeEnd = _dateOnly(end);
    return _dataSource
        .watchProviderMonths(
          businessId: businessId,
          providerId: providerId,
          startMonthKey: _monthKey(rangeStart),
          endMonthKey: _monthKey(rangeEnd),
        )
        .map(
          (months) => _aggregateProviderDateRange(
            months.map(ProviderEarningsMetrics.fromJson),
            start: rangeStart,
            end: rangeEnd,
          ),
        );
  }

  String _monthKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}';

  BusinessMonthlyMetrics _aggregateDateRange(
    Iterable<BusinessMonthlyMetrics> months, {
    required DateTime start,
    required DateTime end,
  }) {
    final dailyRevenue = <String, double>{};
    final dailyBookings = <String, double>{};
    final dailyOnlineEarnings = <String, double>{};
    final dailyCashEarnings = <String, double>{};
    for (final month in months) {
      _addInRange(month.dailyRevenue, dailyRevenue, start, end);
      _addInRange(month.dailyBookings, dailyBookings, start, end);
      _addInRange(month.dailyOnlineEarnings, dailyOnlineEarnings, start, end);
      _addInRange(month.dailyCashEarnings, dailyCashEarnings, start, end);
    }
    return BusinessMonthlyMetrics(
      revenue: _sum(dailyRevenue),
      bookingCount: _sum(dailyBookings).round(),
      onlineEarnings: _sum(dailyOnlineEarnings),
      cashEarnings: _sum(dailyCashEarnings),
      dailyRevenue: dailyRevenue,
      dailyBookings: dailyBookings,
      dailyOnlineEarnings: dailyOnlineEarnings,
      dailyCashEarnings: dailyCashEarnings,
    );
  }

  ProviderEarningsMetrics _aggregateProviderDateRange(
    Iterable<ProviderEarningsMetrics> months, {
    required DateTime start,
    required DateTime end,
  }) {
    final dailyGrossRevenue = <String, double>{};
    final dailyProviderEarnings = <String, double>{};
    final dailyAppointments = <String, double>{};
    for (final month in months) {
      _addInRange(month.dailyGrossRevenue, dailyGrossRevenue, start, end);
      _addInRange(
        month.dailyProviderEarnings,
        dailyProviderEarnings,
        start,
        end,
      );
      _addInRange(month.dailyAppointments, dailyAppointments, start, end);
    }
    return ProviderEarningsMetrics(
      grossRevenue: _sum(dailyGrossRevenue),
      providerEarnings: _sum(dailyProviderEarnings),
      appointmentCount: _sum(dailyAppointments).round(),
      dailyGrossRevenue: dailyGrossRevenue,
      dailyProviderEarnings: dailyProviderEarnings,
      dailyAppointments: dailyAppointments,
    );
  }

  void _addInRange(
    Map<String, double> source,
    Map<String, double> target,
    DateTime start,
    DateTime end,
  ) {
    for (final entry in source.entries) {
      final date = DateTime.tryParse(entry.key);
      if (date == null || date.isBefore(start) || date.isAfter(end)) continue;
      target[entry.key] = (target[entry.key] ?? 0) + entry.value;
    }
  }

  double _sum(Map<String, double> values) =>
      values.values.fold(0, (a, b) => a + b);

  DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);
}
