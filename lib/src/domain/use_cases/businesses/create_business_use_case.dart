import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/repositories/businesses_repository.dart';

@injectable
class CreateBusinessUseCase {
  CreateBusinessUseCase(this._repository);

  final BusinessesRepository _repository;

  Future<Result<BusinessModel>> execute(BusinessModel business) =>
      _repository.createBusiness(business);
}
