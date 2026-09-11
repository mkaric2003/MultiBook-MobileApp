import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/create_service_availability_block_request.dart';
import 'package:multibook/src/data/models/service_availability_block_model.dart';
import 'package:multibook/src/domain/repositories/service_availability_repository.dart';

@injectable
class CreateServiceAvailabilityBlockUseCase {
  CreateServiceAvailabilityBlockUseCase(this._repository);

  final ServiceAvailabilityRepository _repository;

  Future<Result<ServiceAvailabilityBlockModel>> execute({
    required String businessId,
    required String staffId,
    required DateTime startAt,
    required DateTime endAt,
  }) => _repository.createBlock(
    businessId: businessId,
    staffId: staffId,
    request: CreateServiceAvailabilityBlockRequest(
      startAt: startAt.toUtc(),
      endAt: endAt.toUtc(),
    ),
  );
}
