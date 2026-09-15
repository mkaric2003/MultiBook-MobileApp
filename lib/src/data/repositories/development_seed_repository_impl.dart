import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/rest_repository_executor.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/data_sources/development_seed_api_data_source.dart';
import 'package:multibook/src/domain/repositories/development_seed_repository.dart';

@LazySingleton(as: DevelopmentSeedRepository)
class DevelopmentSeedRepositoryImpl implements DevelopmentSeedRepository {
  DevelopmentSeedRepositoryImpl(this._source, this._executor);
  final DevelopmentSeedApiDataSource _source;
  final RestRepositoryExecutor _executor;
  @override
  Future<Result<int>> seedStays() => _executor.execute(_source.seedStays);
  @override
  Future<Result<int>> seedServices() => _executor.execute(_source.seedServices);
}
