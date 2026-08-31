import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/appointment_draft_model.dart';
import 'package:multibook/src/data/models/booking_draft_model.dart';
import 'package:multibook/src/domain/repositories/customer_drafts_repository.dart';

@injectable
class CustomerDraftsUseCase {
  CustomerDraftsUseCase(this._repository);

  final CustomerDraftsRepository _repository;

  Future<Result<BookingDraftModel?>> getBookingDraft() =>
      _repository.getBookingDraft();

  Future<Result<BookingDraftModel>> saveBookingDraft(BookingDraftModel draft) =>
      _repository.saveBookingDraft(draft);

  Future<Result<void>> deleteBookingDraft() => _repository.deleteBookingDraft();

  Future<Result<AppointmentDraftModel?>> getAppointmentDraft() =>
      _repository.getAppointmentDraft();

  Future<Result<AppointmentDraftModel>> saveAppointmentDraft(
    AppointmentDraftModel draft,
  ) => _repository.saveAppointmentDraft(draft);

  Future<Result<void>> deleteAppointmentDraft() =>
      _repository.deleteAppointmentDraft();
}
