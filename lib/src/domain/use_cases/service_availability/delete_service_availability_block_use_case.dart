import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/service_availability_repository.dart';

@injectable
class DeleteServiceAvailabilityBlockUseCase {
  DeleteServiceAvailabilityBlockUseCase(this._repository);

  final ServiceAvailabilityRepository _repository;

  Future<Result<void>> execute({
    required String businessId,
    required String staffId,
    required String blockId,
  }) => _repository.deleteBlock(
    businessId: businessId,
    staffId: staffId,
    blockId: blockId,
  );
}
