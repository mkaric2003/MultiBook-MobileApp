import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/data/repositories/user_repository.dart';
import 'package:aquabook/src/features/business-side/home/bloc/client_entry_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClientEntryCubit extends Cubit<ClientEntryState> {
  ClientEntryCubit(this._businessRepository, this._userRepository)
    : super(const ClientEntryState());

  final BusinessRepository _businessRepository;
  final UserRepository _userRepository;

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
