import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/data/repositories/saved_business_repository.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/cubit/stay_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class StayDetailCubit extends Cubit<StayDetailState> {
  StayDetailCubit(this._businessRepository, this._savedRepository)
    : super(const StayDetailState());

  final BusinessRepository _businessRepository;
  final SavedBusinessRepository _savedRepository;

  Future<void> loadStay(String businessId) async {
    emit(const StayDetailState(isLoading: true));
    try {
      final business = await _businessRepository.getBusiness(
        businessId: businessId,
      );
      if (business == null) {
        emit(const StayDetailState(errorMessage: 'This stay is unavailable.'));
        return;
      }
      emit(
        StayDetailState(
          business: business,
          isSaved: await _savedRepository.isSaved(business.id),
        ),
      );
    } on BusinessException catch (error) {
      emit(StayDetailState(errorMessage: error.message));
    }
  }

  Future<void> toggleSaved(StayListing stay) async {
    final wasSaved = state.isSaved;
    emit(StayDetailState(business: state.business, isSaved: !wasSaved));
    await _savedRepository.toggle(stay, wasSaved);
  }
}
