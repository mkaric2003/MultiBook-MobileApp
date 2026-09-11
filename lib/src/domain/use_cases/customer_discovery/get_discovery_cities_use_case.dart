import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/customer_discovery_repository.dart';

@injectable
class GetDiscoveryCitiesUseCase {
  GetDiscoveryCitiesUseCase(this._repository);
  final CustomerDiscoveryRepository _repository;

  Future<Result<List<String>>> execute() => _repository.listCities();
}
