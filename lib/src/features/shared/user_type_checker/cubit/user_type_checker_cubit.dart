import 'package:multibook/src/data/enums/user_type.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/use_cases/users/update_user_role_use_case.dart';
import 'package:multibook/src/features/shared/user_type_checker/cubit/user_type_checker_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserTypeCheckerCubit extends Cubit<UserTypeCheckerState> {
  UserTypeCheckerCubit(this._updateUserRoleUseCase)
    : super(const UserTypeCheckerState());

  final UpdateUserRoleUseCase _updateUserRoleUseCase;

  void selectType(UserType type) =>
      emit(UserTypeCheckerState(selectedType: type));

  Future<void> continueWithSelectedType() async {
    final type = state.selectedType;
    if (type == null || state.isLoading) {
      return;
    }

    emit(UserTypeCheckerState(selectedType: type, isLoading: true));
    final result = await _updateUserRoleUseCase.execute(type);
    switch (result) {
      case Success():
        emit(UserTypeCheckerState(selectedType: type, isCompleted: true));
      case FailureResult():
        emit(
          UserTypeCheckerState(
            selectedType: type,
            errorMessage: 'We could not save your choice. Please try again.',
          ),
        );
    }
  }
}
