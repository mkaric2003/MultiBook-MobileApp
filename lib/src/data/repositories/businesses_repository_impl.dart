import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/rest_repository_executor.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/data_sources/businesses_api_data_source.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/repositories/businesses_repository.dart';

@LazySingleton(as: BusinessesRepository)
class BusinessesRepositoryImpl implements BusinessesRepository {
  BusinessesRepositoryImpl(this._dataSource, this._executor);

  final BusinessesApiDataSource _dataSource;
  final RestRepositoryExecutor _executor;

  @override
  Future<Result<BusinessModel>> createBusiness(BusinessModel business) =>
      _executor.execute(() => _dataSource.createBusiness(business));

  @override
  Future<Result<List<BusinessModel>>> getOwnedBusinesses() =>
      _executor.execute(_dataSource.getOwnedBusinesses);

  @override
  Future<Result<BusinessModel>> getOwnedBusiness(String businessId) =>
      _executor.execute(() => _dataSource.getOwnedBusiness(businessId));

  @override
  Future<Result<BusinessModel>> updateBusiness(BusinessModel business) =>
      _executor.execute(() => _dataSource.updateBusiness(business));
}
