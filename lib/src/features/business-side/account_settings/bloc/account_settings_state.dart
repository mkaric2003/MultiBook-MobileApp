import 'package:multibook/src/data/models/user_model.dart';

class AccountSettingsState {
  const AccountSettingsState({
    this.isLoading = true,
    this.isSaving = false,
    this.user,
    this.profileImagePath,
    this.errorMessage,
    this.successMessage,
  });

  final bool isLoading;
  final bool isSaving;
  final UserModel? user;
  final String? profileImagePath;
  final String? errorMessage;
  final String? successMessage;
}
