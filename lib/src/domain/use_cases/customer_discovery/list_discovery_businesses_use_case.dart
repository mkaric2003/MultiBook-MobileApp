import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/repositories/customer_discovery_repository.dart';

@injectable
class ListDiscoveryBusinessesUseCase {
  ListDiscoveryBusinessesUseCase(this._repository);
  final CustomerDiscoveryRepository _repository;

  Future<Result<List<BusinessModel>>> execute({
    required BusinessType type,
    required int offset,
    int limit = 10,
  }) => _repository.listBusinesses(type: type, offset: offset, limit: limit);
}
