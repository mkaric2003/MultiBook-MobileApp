import 'package:aquabook/src/data/repositories/authentication_repository.dart';
import 'package:aquabook/src/features/customer-side/profile/cubit/customer_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CustomerProfileCubit extends Cubit<CustomerProfileState> {
  CustomerProfileCubit(this._authenticationRepository)
    : super(const CustomerProfileState());

  final AuthenticationRepository _authenticationRepository;

  Future<void> signOut() async {
    if (state.isLoading) {
      return;
    }

    emit(const CustomerProfileState(isLoading: true));
    try {
      await _authenticationRepository.signOut();
      emit(const CustomerProfileState(isSignedOut: true));
    } on AuthenticationException catch (error) {
      emit(CustomerProfileState(errorMessage: error.message));
    }
  }
}
