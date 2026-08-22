import 'package:aquabook/src/data/enums/currency_code.dart';
import 'package:aquabook/src/data/enums/user_type.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'user_model.mapper.dart';

@MappableClass()
class UserModel with UserModelMappable {
  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    this.type = UserType.provider,
    this.selectedBusinessId,
    this.phoneNumber,
    this.profileImageUrl,
    this.countryCode,
    this.dateOfBirth,
    this.address,
    this.city,
    this.businessCurrency = CurrencyCode.bam,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final UserType type;
  final String? selectedBusinessId;
  final String? phoneNumber;
  final String? profileImageUrl;
  final String? countryCode;
  final DateTime? dateOfBirth;
  final String? address;
  final String? city;
  final CurrencyCode businessCurrency;
}
