import 'package:aquabook/src/data/enums/user_type.dart';

class UserTypeCheckerState {
  const UserTypeCheckerState({
    this.selectedType,
    this.isLoading = false,
    this.isCompleted = false,
    this.errorMessage,
  });

  final UserType? selectedType;
  final bool isLoading;
  final bool isCompleted;
  final String? errorMessage;
}
