import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/data/models/appointment_draft_model.dart';

class CreateAppointmentArguments {
  const CreateAppointmentArguments({
    required this.business,
    required this.initialOfferingId,
    this.draft,
  });

  final BusinessModel business;
  final String initialOfferingId;
  final AppointmentDraftModel? draft;
}
