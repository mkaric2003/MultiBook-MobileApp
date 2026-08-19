import 'package:aquabook/src/data/models/appointment_draft_model.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/data/repositories/appointment_draft_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppointmentDraftCubit extends Cubit<bool> {
  AppointmentDraftCubit(this._repository) : super(false);

  final AppointmentDraftRepository _repository;

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
      await _repository.saveDraft(
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
