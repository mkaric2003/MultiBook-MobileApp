import 'package:aquabook/src/data/enums/user_type.dart';

class ClientEntryState {
  const ClientEntryState({
    this.isLoading = true,
    this.hasExistingBusiness = false,
    this.userType,
  });

  final bool isLoading;
  final bool hasExistingBusiness;
  final UserType? userType;
}
