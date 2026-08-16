import 'package:dart_mappable/dart_mappable.dart';

part 'signin_state.mapper.dart';

@MappableClass()
class SigninState with SigninStateMappable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final String? successMessage;

  SigninState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.successMessage,
  });
}
