import 'package:dart_mappable/dart_mappable.dart';
import 'package:aquabook/src/data/enums/user_type.dart';

part 'signin_state.mapper.dart';

@MappableClass()
class SigninState with SigninStateMappable {
  final bool isLoading;
  final bool isSuccess;
  final bool requiresUserTypeSelection;
  final UserType? userType;
  final String? errorMessage;
  final String? successMessage;

  SigninState({
    this.isLoading = false,
    this.isSuccess = false,
    this.requiresUserTypeSelection = false,
    this.userType,
    this.errorMessage,
    this.successMessage,
  });
}
