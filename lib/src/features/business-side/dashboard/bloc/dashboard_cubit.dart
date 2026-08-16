import 'package:aquabook/src/data/enums/user_type.dart';
import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/data/repositories/user_repository.dart';
import 'package:aquabook/src/features/business-side/dashboard/bloc/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this._userRepository, this._businessRepository)
    : super(const DashboardState());

  final UserRepository _userRepository;
  final BusinessRepository _businessRepository;

  Future<void> load() async {
    final user = await _userRepository.getCurrentUser();
    if (user == null || user.type != UserType.provider) {
      emit(const DashboardState(isLoading: false));
      return;
    }

    var business = user.selectedBusinessId == null
        ? null
        : await _businessRepository.getBusiness(
            businessId: user.selectedBusinessId!,
          );
    business ??= await _businessRepository.getFirstOwnedBusiness();

    if (business != null && business.id != user.selectedBusinessId) {
      await _userRepository.setSelectedBusiness(businessId: business.id);
    }

    emit(DashboardState(isLoading: false, business: business));
  }
}
