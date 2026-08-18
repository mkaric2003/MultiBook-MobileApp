import 'package:aquabook/src/data/repositories/authentication_repository.dart';
import 'package:aquabook/src/data/repositories/user_repository.dart';
import 'package:aquabook/src/features/shared/sign_in/cubit/signin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this._authenticationRepository, this._userRepository)
    : super(SigninState());

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  Future<void> signIn({required String email, required String password}) async {
    emit(SigninState(isLoading: true));

    try {
      await _authenticationRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _completeSignIn();
    } on AuthenticationException catch (error) {
      emit(SigninState(errorMessage: error.message));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(SigninState(isLoading: true));

    try {
      final isNewUser = await _authenticationRepository.signInWithGoogle();
      if (isNewUser) {
        emit(SigninState(isSuccess: true, requiresUserTypeSelection: true));
        return;
      }
      await _completeSignIn();
    } on AuthenticationCancelledException {
      emit(SigninState());
    } on AuthenticationException catch (error) {
      emit(SigninState(errorMessage: error.message));
    }
  }

  Future<void> _completeSignIn() async {
    final user = await _userRepository.getCurrentUser();
    emit(SigninState(isSuccess: true, userType: user?.type));
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
