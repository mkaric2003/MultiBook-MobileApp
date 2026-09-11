import 'package:multibook/src/data/models/appointment_draft_model.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/use_cases/drafts/save_appointment_draft_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppointmentDraftCubit extends Cubit<bool> {
  AppointmentDraftCubit(this._saveAppointmentDraftUseCase) : super(false);

  final SaveAppointmentDraftUseCase _saveAppointmentDraftUseCase;

  Future<void> save({
    required BusinessModel business,
    required List<String> offeringIds,
    required String? providerId,
    String? providerName,
    required DateTime date,
    required int? startMinutes,
    List<String> addOnIds = const [],
  }) async {
    emit(true);
    try {
      await _saveAppointmentDraftUseCase.execute(
        AppointmentDraftModel(
          id: '',
          businessId: business.id,
          businessName: business.name,
          businessImageUrl: business.coverPhotoUrl ?? business.logoUrl ?? '',
          selectedOfferingIds: offeringIds,
          selectedProviderId: providerId,
          selectedProviderName: providerName,
          date: date,
          startMinutes: startMinutes,
          selectedAddOnIds: addOnIds,
        ),
      );
    } finally {
      emit(false);
    }
  }
}
