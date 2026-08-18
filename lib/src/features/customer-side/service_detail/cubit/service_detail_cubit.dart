import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/data/repositories/saved_business_repository.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:aquabook/src/features/customer-side/service_detail/cubit/service_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ServiceDetailCubit extends Cubit<ServiceDetailState> {
  ServiceDetailCubit(this._businessRepository, this._savedRepository)
    : super(const ServiceDetailState());

  final BusinessRepository _businessRepository;
  final SavedBusinessRepository _savedRepository;

  Future<void> loadService(String businessId) async {
    emit(const ServiceDetailState(isLoading: true));
    try {
      final business = await _businessRepository.getBusiness(
        businessId: businessId,
      );
      if (business == null) {
        emit(
          const ServiceDetailState(
            errorMessage: 'This service is unavailable.',
          ),
        );
        return;
      }
      emit(
        ServiceDetailState(
          business: business,
          isSaved: await _savedRepository.isSaved(business.id),
        ),
      );
    } on BusinessException catch (error) {
      emit(ServiceDetailState(errorMessage: error.message));
    }
  }

  Future<void> toggleSaved(ServiceListing service) async {
    final wasSaved = state.isSaved;
    emit(ServiceDetailState(business: state.business, isSaved: !wasSaved));
    await _savedRepository.toggleService(service, wasSaved);
  }
}
