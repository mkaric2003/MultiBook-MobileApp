import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/customer_drafts_repository.dart';

@injectable
class DeleteBookingDraftUseCase {
  DeleteBookingDraftUseCase(this._repository);

  final CustomerDraftsRepository _repository;

  Future<Result<void>> execute() => _repository.deleteBookingDraft();
}
