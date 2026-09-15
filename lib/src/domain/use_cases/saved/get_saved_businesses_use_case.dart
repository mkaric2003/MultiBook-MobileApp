import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/saved_business_repository.dart';
import 'package:multibook/src/data/models/business_model.dart';

@injectable
class GetSavedBusinessesUseCase {
  GetSavedBusinessesUseCase(this._repository);
  final SavedBusinessRepository _repository;
  Future<Result<List<BusinessModel>>> execute() => _repository.list();
}
