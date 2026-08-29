import 'package:multibook/src/data/models/service_offering_model.dart';
import 'package:multibook/src/data/models/service_provider_model.dart';
import 'package:multibook/src/data/models/stay_room_model.dart';
import 'package:multibook/src/data/repositories/business_repository.dart';
import 'package:multibook/src/data/repositories/user_repository.dart';
import 'package:multibook/src/features/business-side/manage_catalog/bloc/manage_catalog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ManageCatalogCubit extends Cubit<ManageCatalogState> {
  ManageCatalogCubit(this._businessRepository, this._userRepository)
    : super(const ManageCatalogState());

  final BusinessRepository _businessRepository;
  final UserRepository _userRepository;

  Future<void> load() async {
    emit(const ManageCatalogState(isLoading: true));
    final user = await _userRepository.getCurrentUser();
    final businessId = user?.selectedBusinessId;
    final business = businessId == null
        ? await _businessRepository.getFirstOwnedBusiness()
        : await _businessRepository.getBusiness(businessId: businessId);
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
      await _businessRepository.updateManageableCatalog(
        business: business,
        rooms: rooms ?? business.stayDetails?.rooms ?? const [],
        offerings: offerings ?? business.serviceDetails?.offerings ?? const [],
        providers:
            providers ??
            business.serviceDetails?.availableProviders ??
            const [],
      );
      await load();
    } on BusinessException catch (error) {
      emit(ManageCatalogState(business: business, errorMessage: error.message));
    }
  }
}
