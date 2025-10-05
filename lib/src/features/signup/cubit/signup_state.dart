import 'package:dart_mappable/dart_mappable.dart';

part 'signup_state.mapper.dart';

@MappableClass()
class SignupState with SignupStateMappable {
  final bool isLoading;

  SignupState({this.isLoading = false});
}
