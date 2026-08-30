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
