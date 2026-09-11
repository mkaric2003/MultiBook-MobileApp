import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/appointment_draft_model.dart';
import 'package:multibook/src/data/models/booking_draft_model.dart';

abstract class CustomerDraftsRepository {
  Future<Result<BookingDraftModel?>> getBookingDraft();
  Future<Result<BookingDraftModel>> saveBookingDraft(BookingDraftModel draft);
  Future<Result<void>> deleteBookingDraft();

  Future<Result<AppointmentDraftModel?>> getAppointmentDraft();
  Future<Result<AppointmentDraftModel>> saveAppointmentDraft(
    AppointmentDraftModel draft,
  );
  Future<Result<void>> deleteAppointmentDraft();
}
