import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/rest_repository_executor.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/data_sources/saved_business_api_data_source.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/repositories/saved_business_repository.dart';

@LazySingleton(as: SavedBusinessRepository)
class SavedBusinessRepositoryImpl implements SavedBusinessRepository {
  SavedBusinessRepositoryImpl(this._source, this._executor);
  final SavedBusinessApiDataSource _source;
  final RestRepositoryExecutor _executor;
  @override
  Future<Result<void>> save(String businessId) =>
      _executor.execute(() => _source.save(businessId));
  @override
  Future<Result<void>> remove(String businessId) =>
      _executor.execute(() => _source.remove(businessId));
  @override
  Future<Result<bool>> isSaved(String businessId) =>
      _executor.execute(() => _source.isSaved(businessId));
  @override
  Future<Result<List<BusinessModel>>> list() => _executor.execute(_source.list);
}
