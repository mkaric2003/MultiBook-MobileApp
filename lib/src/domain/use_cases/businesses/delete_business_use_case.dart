import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/business_deletion_repository.dart';

@injectable
class DeleteBusinessUseCase {
  DeleteBusinessUseCase(this._repository);

  final BusinessDeletionRepository _repository;

  Future<Result<void>> execute(String businessId) =>
      _repository.deleteBusiness(businessId);
}
