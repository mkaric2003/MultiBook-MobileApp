import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/rest_repository_executor.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/data_sources/service_availability_api_data_source.dart';
import 'package:multibook/src/data/models/create_service_availability_block_request.dart';
import 'package:multibook/src/data/models/service_availability_block_model.dart';
import 'package:multibook/src/domain/repositories/service_availability_repository.dart';

@LazySingleton(as: ServiceAvailabilityRepository)
class ServiceAvailabilityRepositoryImpl
    implements ServiceAvailabilityRepository {
  ServiceAvailabilityRepositoryImpl(this._source, this._executor);

  final ServiceAvailabilityApiDataSource _source;
  final RestRepositoryExecutor _executor;

  @override
  Future<Result<List<ServiceAvailabilityBlockModel>>> getBlocks({
    required String businessId,
    required String staffId,
  }) => _executor.execute(
    () => _source.getBlocks(businessId: businessId, staffId: staffId),
  );

  @override
  Future<Result<ServiceAvailabilityBlockModel>> createBlock({
    required String businessId,
    required String staffId,
    required CreateServiceAvailabilityBlockRequest request,
  }) => _executor.execute(
    () => _source.createBlock(
      businessId: businessId,
      staffId: staffId,
      request: request,
    ),
  );

  @override
  Future<Result<void>> deleteBlock({
    required String businessId,
    required String staffId,
    required String blockId,
  }) => _executor.execute(
    () => _source.deleteBlock(
      businessId: businessId,
      staffId: staffId,
      blockId: blockId,
    ),
  );
}
