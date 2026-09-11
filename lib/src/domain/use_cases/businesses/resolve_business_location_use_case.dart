import 'package:injectable/injectable.dart';
import 'package:multibook/src/data/models/business_location_model.dart';
import 'package:multibook/src/domain/repositories/business_location_repository.dart';

@injectable
class ResolveBusinessLocationUseCase {
  ResolveBusinessLocationUseCase(this._repository);

  final BusinessLocationRepository _repository;

  Future<BusinessLocationModel?> execute({
    required double latitude,
    required double longitude,
  }) => _repository.resolve(latitude: latitude, longitude: longitude);
}
