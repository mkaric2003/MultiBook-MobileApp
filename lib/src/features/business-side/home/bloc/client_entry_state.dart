import 'package:multibook/src/data/enums/user_type.dart';
import 'package:multibook/src/data/models/user_model.dart';

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
