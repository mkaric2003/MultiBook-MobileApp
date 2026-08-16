import 'package:aquabook/src/data/repositories/authentication_repository.dart';
import 'package:aquabook/src/features/shared/sign_in/cubit/signin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this._authenticationRepository) : super(SigninState());

  final AuthenticationRepository _authenticationRepository;

  Future<void> signIn({required String email, required String password}) async {
    emit(SigninState(isLoading: true));

    try {
      await _authenticationRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SigninState(isSuccess: true));
    } on AuthenticationException catch (error) {
      emit(SigninState(errorMessage: error.message));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(SigninState(isLoading: true));

    try {
      await _authenticationRepository.signInWithGoogle();
      emit(SigninState(isSuccess: true));
    } on AuthenticationCancelledException {
      emit(SigninState());
    } on AuthenticationException catch (error) {
      emit(SigninState(errorMessage: error.message));
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    emit(SigninState(isLoading: true));

    try {
      await _authenticationRepository.sendPasswordResetEmail(email: email);
      emit(
        SigninState(
          successMessage: 'Password reset email sent. Check your inbox.',
        ),
      );
    } on AuthenticationException catch (error) {
      emit(SigninState(errorMessage: error.message));
    }
  }
}
