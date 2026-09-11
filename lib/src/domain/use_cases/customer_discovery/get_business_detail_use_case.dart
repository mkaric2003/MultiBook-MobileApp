import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/repositories/customer_discovery_repository.dart';

@lazySingleton
class GetBusinessDetailUseCase {
  GetBusinessDetailUseCase(this._repository);

  final CustomerDiscoveryRepository _repository;

  Future<Result<BusinessModel>> execute(String businessId) =>
      _repository.getBusinessDetail(businessId);
}
