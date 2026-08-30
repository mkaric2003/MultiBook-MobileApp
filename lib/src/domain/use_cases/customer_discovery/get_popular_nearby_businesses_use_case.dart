import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/repositories/customer_discovery_repository.dart';

@injectable
class GetPopularNearbyBusinessesUseCase {
  GetPopularNearbyBusinessesUseCase(this._repository);
  final CustomerDiscoveryRepository _repository;

  Future<Result<List<BusinessModel>>> execute({
    required BusinessType type,
    required String city,
    required int offset,
    int limit = 10,
  }) => _repository.popularNearCity(
    type: type,
    city: city,
    offset: offset,
    limit: limit,
  );

  Future<Result<List<BusinessModel>>> recommendedStays() =>
      _repository.recommendedStays();
}
