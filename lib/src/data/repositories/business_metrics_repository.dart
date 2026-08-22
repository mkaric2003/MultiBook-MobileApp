import 'package:aquabook/src/data/data_sources/business_metrics_data_source.dart';
import 'package:aquabook/src/features/business-side/dashboard/domain/models/business_metrics.dart';
import 'package:aquabook/src/features/business-side/dashboard/domain/models/business_monthly_metrics.dart';
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

  String _monthKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}';
}
