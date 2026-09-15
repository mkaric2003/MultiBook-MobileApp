import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/appointment_draft_model.dart';
import 'package:multibook/src/domain/repositories/customer_drafts_repository.dart';

@injectable
class SaveAppointmentDraftUseCase {
  SaveAppointmentDraftUseCase(this._repository);

  final CustomerDraftsRepository _repository;

  Future<Result<AppointmentDraftModel>> execute(AppointmentDraftModel draft) =>
      _repository.saveAppointmentDraft(draft);
}
