import 'package:multibook/src/data/repositories/authentication_repository.dart';
import 'package:multibook/src/data/repositories/user_repository.dart';
import 'package:multibook/src/features/shared/sign_in/cubit/signin_state.dart';
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
      if (isClosed) return;
      await _completeSignIn();
    } on AuthenticationException catch (error) {
      if (!isClosed) {
        emit(SigninState(errorMessage: error.message));
      }
    }
  }

  Future<void> signInWithGoogle() async {
    emit(SigninState(isLoading: true));

    try {
      final isNewUser = await _authenticationRepository.signInWithGoogle();
      if (isClosed) return;
      if (isNewUser) {
        emit(SigninState(isSuccess: true, requiresUserTypeSelection: true));
        return;
      }
      await _completeSignIn();
    } on AuthenticationCancelledException {
      if (!isClosed) emit(SigninState());
    } on AuthenticationException catch (error) {
      if (!isClosed) {
        emit(SigninState(errorMessage: error.message));
      }
    }
  }

  Future<void> _completeSignIn() async {
    final user = await _userRepository.getCurrentUser();
    if (!isClosed) {
      emit(SigninState(isSuccess: true, userType: user?.type));
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    emit(SigninState(isLoading: true));

    try {
      await _authenticationRepository.sendPasswordResetEmail(email: email);
      if (!isClosed) {
        emit(
          SigninState(
            successMessage: 'Password reset email sent. Check your inbox.',
          ),
        );
      }
    } on AuthenticationException catch (error) {
      if (!isClosed) {
        emit(SigninState(errorMessage: error.message));
      }
    }
  }
}
