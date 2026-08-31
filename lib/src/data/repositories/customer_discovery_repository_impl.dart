import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/rest_repository_executor.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/data_sources/customer_discovery_api_data_source.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/repositories/customer_discovery_repository.dart';

@LazySingleton(as: CustomerDiscoveryRepository)
class CustomerDiscoveryRepositoryImpl implements CustomerDiscoveryRepository {
  CustomerDiscoveryRepositoryImpl(this._dataSource, this._executor);
  final CustomerDiscoveryApiDataSource _dataSource;
  final RestRepositoryExecutor _executor;

  @override
  Future<Result<BusinessModel>> getBusinessDetail(String businessId) =>
      _executor.execute(() => _dataSource.getBusinessDetail(businessId));

  @override
  Future<Result<List<BusinessModel>>> recommendedStays() =>
      _executor.execute(_dataSource.recommendedStays);

  @override
  Future<Result<List<BusinessModel>>> listBusinesses({
    required BusinessType type,
    required int offset,
    int limit = 10,
  }) => _executor.execute(
    () => _dataSource.listBusinesses(type: type, offset: offset, limit: limit),
  );

  @override
  Future<Result<List<BusinessModel>>> searchBusinesses({
    required BusinessType type,
    required String query,
    int limit = 20,
  }) => _executor.execute(
    () => _dataSource.searchBusinesses(type: type, query: query, limit: limit),
  );

  @override
  Future<Result<List<BusinessModel>>> popularNearCity({
    required BusinessType type,
    required String city,
    required int offset,
    int limit = 10,
  }) => _executor.execute(
    () => _dataSource.popularNearCity(
      type: type,
      city: city,
      offset: offset,
      limit: limit,
    ),
  );
}
