import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/data/repositories/business_repository.dart';
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart';
import 'package:multibook/src/features/business-side/my_businesses/bloc/my_businesses_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MyBusinessesCubit extends Cubit<MyBusinessesState> {
  MyBusinessesCubit(this._businessRepository, this._userRepository)
    : super(const MyBusinessesState());

  final BusinessRepository _businessRepository;
  final UserProfileUseCase _userRepository;

  Future<void> load() async {
    final businesses = await _businessRepository.getOwnedBusinesses();
    emit(MyBusinessesState(isLoading: false, businesses: businesses));
  }

  Future<void> selectBusiness(String businessId) async {
    if (state.isSelecting) {
      return;
    }

    emit(
      MyBusinessesState(
        isLoading: false,
        isSelecting: true,
        businesses: state.businesses,
      ),
    );
    await _userRepository.setSelectedBusiness(businessId: businessId);
    emit(MyBusinessesState(isLoading: false, businesses: state.businesses));
  }

  Future<bool> deleteBusiness(BusinessModel business) async {
    try {
      await _businessRepository.deleteBusiness(business);
      return true;
    } on BusinessException {
      return false;
    }
  }

  void removeBusiness(String businessId) {
    emit(
      MyBusinessesState(
        isLoading: false,
        businesses: state.businesses
            .where((business) => business.id != businessId)
            .toList(),
      ),
    );
  }
}
