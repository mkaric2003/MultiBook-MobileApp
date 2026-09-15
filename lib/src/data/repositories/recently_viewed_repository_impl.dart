import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/rest_repository_executor.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/data_sources/recently_viewed_api_data_source.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/repositories/recently_viewed_repository.dart';

@LazySingleton(as: RecentlyViewedRepository)
class RecentlyViewedRepositoryImpl implements RecentlyViewedRepository {
  RecentlyViewedRepositoryImpl(this._source, this._executor);
  final RecentlyViewedApiDataSource _source;
  final RestRepositoryExecutor _executor;
  @override
  Future<Result<void>> record(String businessId) =>
      _executor.execute(() => _source.record(businessId));
  @override
  Future<Result<List<BusinessModel>>> list(
    BusinessType type, {
    int limit = 10,
  }) => _executor.execute(() => _source.list(type, limit: limit));
}
