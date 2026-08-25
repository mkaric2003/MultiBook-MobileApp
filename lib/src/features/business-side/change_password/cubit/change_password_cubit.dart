import 'package:aquabook/src/data/repositories/authentication_repository.dart';
import 'package:aquabook/src/features/business-side/change_password/cubit/change_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this._authenticationRepository)
    : super(const ChangePasswordState());

  final AuthenticationRepository _authenticationRepository;

  Future<void> submit({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (state.isSubmitting) return;
    emit(const ChangePasswordState(isSubmitting: true));
    try {
      await _authenticationRepository.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      emit(const ChangePasswordState(isSuccess: true));
    } on AuthenticationException catch (error) {
      emit(ChangePasswordState(errorMessage: error.message));
    }
  }
}
