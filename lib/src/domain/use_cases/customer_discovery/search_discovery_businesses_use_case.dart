import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/repositories/customer_discovery_repository.dart';

@injectable
class SearchDiscoveryBusinessesUseCase {
  SearchDiscoveryBusinessesUseCase(this._repository);
  final CustomerDiscoveryRepository _repository;

  Future<Result<List<BusinessModel>>> execute({
    required BusinessType type,
    required String query,
    int limit = 20,
  }) => _repository.searchBusinesses(type: type, query: query, limit: limit);
}
