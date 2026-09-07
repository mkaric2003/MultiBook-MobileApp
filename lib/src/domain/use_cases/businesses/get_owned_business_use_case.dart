import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/repositories/businesses_repository.dart';

/// Retrieves the complete aggregate for provider flows that need full details.
@injectable
class GetOwnedBusinessUseCase {
  GetOwnedBusinessUseCase(this._repository);

  final BusinessesRepository _repository;

  Future<Result<BusinessModel>> execute(String businessId) =>
      _repository.getOwnedBusiness(businessId);
}
