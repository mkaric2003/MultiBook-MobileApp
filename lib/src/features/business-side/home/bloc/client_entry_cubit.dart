import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/enums/user_type.dart';
import 'package:multibook/src/domain/use_cases/businesses/get_selected_business_use_case.dart';
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart';
import 'package:multibook/src/features/business-side/home/bloc/client_entry_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClientEntryCubit extends Cubit<ClientEntryState> {
  ClientEntryCubit(this._getSelectedBusiness, this._userProfileUseCase)
    : super(const ClientEntryState());

  final GetSelectedBusinessUseCase _getSelectedBusiness;
  final UserProfileUseCase _userProfileUseCase;

  Future<void> load() async {
    final user = await _userProfileUseCase.getCurrentUser(forceRefresh: true);
    var hasExistingBusiness = false;
    if (user?.type != UserType.customer) {
      final selectedBusiness = await _getSelectedBusiness.execute(
        user?.selectedBusinessId,
      );
      hasExistingBusiness = switch (selectedBusiness) {
        Success(value: final business) => business != null,
        FailureResult() => false,
      };
    }
    emit(
      ClientEntryState(
        isLoading: false,
        hasExistingBusiness: hasExistingBusiness,
        userType: user?.type,
        user: user,
      ),
    );
  }
}
