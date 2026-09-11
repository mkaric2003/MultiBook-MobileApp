import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/create_service_availability_block_request.dart';
import 'package:multibook/src/data/models/service_availability_block_model.dart';

abstract class ServiceAvailabilityRepository {
  Future<Result<List<ServiceAvailabilityBlockModel>>> getBlocks({
    required String businessId,
    required String staffId,
  });

  Future<Result<ServiceAvailabilityBlockModel>> createBlock({
    required String businessId,
    required String staffId,
    required CreateServiceAvailabilityBlockRequest request,
  });

  Future<Result<void>> deleteBlock({
    required String businessId,
    required String staffId,
    required String blockId,
  });
}
