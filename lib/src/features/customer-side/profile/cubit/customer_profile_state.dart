import 'package:aquabook/src/data/models/user_model.dart';

class CustomerProfileState {
  const CustomerProfileState({
    this.isLoading = false,
    this.isSignedOut = false,
    this.errorMessage,
    this.user,
    this.unreadMessagesCount = 0,
  });

  final bool isLoading;
  final bool isSignedOut;
  final String? errorMessage;
  final UserModel? user;
  final int unreadMessagesCount;
}
