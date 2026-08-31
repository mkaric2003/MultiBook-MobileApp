import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/booking_draft_model.dart';
import 'package:multibook/src/domain/repositories/customer_drafts_repository.dart';

@injectable
class SaveBookingDraftUseCase {
  SaveBookingDraftUseCase(this._repository);

  final CustomerDraftsRepository _repository;

  Future<Result<BookingDraftModel>> execute(BookingDraftModel draft) =>
      _repository.saveBookingDraft(draft);
}
