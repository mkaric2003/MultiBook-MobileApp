import 'package:aquabook/src/data/enums/user_type.dart';
import 'package:aquabook/src/data/repositories/user_repository.dart';
import 'package:aquabook/src/features/shared/user_type_checker/cubit/user_type_checker_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserTypeCheckerCubit extends Cubit<UserTypeCheckerState> {
  UserTypeCheckerCubit(this._userRepository)
    : super(const UserTypeCheckerState());

  final UserRepository _userRepository;

  void selectType(UserType type) =>
      emit(UserTypeCheckerState(selectedType: type));

  Future<void> continueWithSelectedType() async {
    final type = state.selectedType;
    if (type == null || state.isLoading) {
      return;
    }

    emit(UserTypeCheckerState(selectedType: type, isLoading: true));
    try {
      await _userRepository.setUserType(type: type);
      emit(UserTypeCheckerState(selectedType: type, isCompleted: true));
    } on FirebaseException {
      emit(
        UserTypeCheckerState(
          selectedType: type,
          errorMessage: 'We could not save your choice. Please try again.',
        ),
      );
    }
  }
}
