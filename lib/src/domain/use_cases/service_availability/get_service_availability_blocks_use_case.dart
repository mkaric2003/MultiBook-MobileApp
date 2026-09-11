import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/service_availability_block_model.dart';
import 'package:multibook/src/domain/repositories/service_availability_repository.dart';

@injectable
class GetServiceAvailabilityBlocksUseCase {
  GetServiceAvailabilityBlocksUseCase(this._repository);

  final ServiceAvailabilityRepository _repository;

  Future<Result<List<ServiceAvailabilityBlockModel>>> execute({
    required String businessId,
    required String staffId,
  }) => _repository.getBlocks(businessId: businessId, staffId: staffId);
}
