import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/cubit/stay_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class StayDetailCubit extends Cubit<StayDetailState> {
  StayDetailCubit(this._businessRepository) : super(const StayDetailState());

  final BusinessRepository _businessRepository;

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
      emit(StayDetailState(business: business));
    } on BusinessException catch (error) {
      emit(StayDetailState(errorMessage: error.message));
    }
  }
}
