import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/booking_draft_model.dart';
import 'package:multibook/src/domain/repositories/customer_drafts_repository.dart';

@injectable
class GetBookingDraftUseCase {
  GetBookingDraftUseCase(this._repository);

  final CustomerDraftsRepository _repository;

  Future<Result<BookingDraftModel?>> execute() => _repository.getBookingDraft();
}
