import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/development_seed_repository.dart';

@injectable
class DevelopmentSeedUseCase {
  DevelopmentSeedUseCase(this._repository);
  final DevelopmentSeedRepository _repository;
  Future<Result<int>> seedStays() => _repository.seedStays();
  Future<Result<int>> seedServices() => _repository.seedServices();
}
