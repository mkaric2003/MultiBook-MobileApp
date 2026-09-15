import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/networking/api_client.dart';
import 'package:multibook/src/data/models/create_service_availability_block_request.dart';
import 'package:multibook/src/data/models/service_availability_block_model.dart';

@lazySingleton
class ServiceAvailabilityApiDataSource {
  ServiceAvailabilityApiDataSource(this._client);

  final ApiClient _client;

  Future<List<ServiceAvailabilityBlockModel>> getBlocks({
    required String businessId,
    required String staffId,
  }) async {
    final response = await _client.get(_blocksPath(businessId, staffId));
    final items = response.data!['items'] as List<dynamic>;
    return items
        .cast<Map<String, dynamic>>()
        .map(ServiceAvailabilityBlockModelMapper.fromMap)
        .toList();
  }

  Future<ServiceAvailabilityBlockModel> createBlock({
    required String businessId,
    required String staffId,
    required CreateServiceAvailabilityBlockRequest request,
  }) async {
    final response = await _client.post(
      _blocksPath(businessId, staffId),
      data: request.toMap(),
    );
    return ServiceAvailabilityBlockModelMapper.fromMap(response.data!);
  }

  Future<void> deleteBlock({
    required String businessId,
    required String staffId,
    required String blockId,
  }) async {
    await _client.delete('${_blocksPath(businessId, staffId)}/$blockId');
  }

  String _blocksPath(String businessId, String staffId) =>
      '/v1/businesses/$businessId/service/staff/$staffId/availability-blocks';
}
