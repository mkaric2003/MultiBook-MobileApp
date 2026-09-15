import 'package:multibook/src/data/models/service_offering_model.dart';
import 'package:multibook/src/data/models/service_provider_model.dart';
import 'package:multibook/src/data/models/stay_room_model.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/use_cases/businesses/get_selected_business_use_case.dart';
import 'package:multibook/src/domain/use_cases/businesses/update_business_use_case.dart';
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart';
import 'package:multibook/src/features/business-side/manage_catalog/bloc/manage_catalog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ManageCatalogCubit extends Cubit<ManageCatalogState> {
  ManageCatalogCubit(
    this._userRepository,
    this._getSelectedBusiness,
    this._updateBusiness,
  ) : super(const ManageCatalogState());

  final UserProfileUseCase _userRepository;
  final GetSelectedBusinessUseCase _getSelectedBusiness;
  final UpdateBusinessUseCase _updateBusiness;

  Future<void> load() async {
    emit(const ManageCatalogState(isLoading: true));
    final user = await _userRepository.getCurrentUser();
    final result = await _getSelectedBusiness.execute(user?.selectedBusinessId);
    final business = switch (result) {
      Success(value: final value) => value,
      FailureResult() => null,
    };
    if (business == null) {
      emit(const ManageCatalogState(errorMessage: 'Business not found.'));
      return;
    }
    emit(ManageCatalogState(business: business));
  }

  Future<void> save({
    List<StayRoomModel>? rooms,
    List<ServiceOfferingModel>? offerings,
    List<ServiceProviderModel>? providers,
  }) async {
    final business = state.business;
    if (business == null || state.isSaving) return;
    emit(ManageCatalogState(business: business, isSaving: true));
    try {
      final updated = business.copyWith(
        stayDetails: business.stayDetails?.copyWith(
          rooms: rooms ?? business.stayDetails!.rooms,
        ),
        serviceDetails: business.serviceDetails?.copyWith(
          offerings: offerings ?? business.serviceDetails!.offerings,
          providers: providers ?? business.serviceDetails!.providers,
        ),
      );
      final result = await _updateBusiness.execute(updated);
      if (result case FailureResult()) {
        emit(
          ManageCatalogState(
            business: business,
            errorMessage: 'We could not save the business catalog.',
          ),
        );
        return;
      }
      await load();
    } catch (_) {
      emit(
        ManageCatalogState(
          business: business,
          errorMessage: 'We could not save the business catalog.',
        ),
      );
    }
  }
}
