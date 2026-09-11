import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/saved_business_repository.dart';

@injectable
class RemoveSavedBusinessUseCase {
  RemoveSavedBusinessUseCase(this._repository);
  final SavedBusinessRepository _repository;
  Future<Result<void>> execute(String businessId) =>
      _repository.remove(businessId);
}
