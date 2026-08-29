import 'package:multibook/src/data/repositories/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'signup_state.dart';

@injectable
class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this._authenticationRepository) : super(SignupState());

  final AuthenticationRepository _authenticationRepository;

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(SignupState(isLoading: true));

    try {
      await _authenticationRepository.signUp(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );
      emit(SignupState(isSuccess: true, requiresUserTypeSelection: true));
    } on AuthenticationException catch (error) {
      emit(SignupState(errorMessage: error.message));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(SignupState(isLoading: true));

    try {
      final isNewUser = await _authenticationRepository.signInWithGoogle();
      emit(SignupState(isSuccess: true, requiresUserTypeSelection: isNewUser));
    } on AuthenticationCancelledException {
      emit(SignupState());
    } on AuthenticationException catch (error) {
      emit(SignupState(errorMessage: error.message));
    }
  }
}
