import 'package:aquabook/src/data/enums/user_type.dart';
import 'package:aquabook/src/data/models/user_model.dart';

class ClientEntryState {
  const ClientEntryState({
    this.isLoading = true,
    this.hasExistingBusiness = false,
    this.userType,
    this.user,
  });

  final bool isLoading;
  final bool hasExistingBusiness;
  final UserType? userType;
  final UserModel? user;
}
