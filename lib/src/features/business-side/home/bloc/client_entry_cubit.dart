import 'package:multibook/src/data/repositories/business_repository.dart';
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart';
import 'package:multibook/src/features/business-side/home/bloc/client_entry_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClientEntryCubit extends Cubit<ClientEntryState> {
  ClientEntryCubit(this._businessRepository, this._userRepository)
    : super(const ClientEntryState());

  final BusinessRepository _businessRepository;
  final UserProfileUseCase _userRepository;

  Future<void> load() async {
    final user = await _userRepository.getCurrentUser();
    final hasExistingBusiness = await _businessRepository.hasBusinesses();
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
