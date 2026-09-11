import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/rest_repository_executor.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/data_sources/businesses_api_data_source.dart';
import 'package:multibook/src/domain/repositories/business_deletion_repository.dart';

@LazySingleton(as: BusinessDeletionRepository)
class BusinessDeletionRepositoryImpl implements BusinessDeletionRepository {
  BusinessDeletionRepositoryImpl(this._source, this._executor);

  final BusinessesApiDataSource _source;
  final RestRepositoryExecutor _executor;

  @override
  Future<Result<void>> deleteBusiness(String businessId) =>
      _executor.execute(() => _source.deleteBusiness(businessId));
}
