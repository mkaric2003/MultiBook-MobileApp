import 'package:dart_mappable/dart_mappable.dart';

part 'signup_state.mapper.dart';

@MappableClass()
class SignupState with SignupStateMappable {
  final bool isLoading;
  final bool isSuccess;
  final bool requiresUserTypeSelection;
  final String? errorMessage;

  SignupState({
    this.isLoading = false,
    this.isSuccess = false,
    this.requiresUserTypeSelection = false,
    this.errorMessage,
  });
}
