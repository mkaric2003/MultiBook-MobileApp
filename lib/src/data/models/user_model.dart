import 'package:multibook/src/data/enums/currency_code.dart';
import 'package:multibook/src/data/enums/user_type.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'user_model.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class UserModel with UserModelMappable {
  const UserModel({
    required this.id,
    this.firstName = '',
    this.lastName = '',
    this.fullName = '',
    this.email = '',
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

  factory UserModel.fromMap(Map<String, dynamic> map) =>
      UserModelMapper.fromMap(map);

  factory UserModel.fromJson(String json) => UserModelMapper.fromJson(json);

  final String id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  @MappableField(key: 'role')
  final UserType type;
  final String? selectedBusinessId;
  @MappableField(key: 'phone_e164')
  final String? phoneNumber;
  @MappableField(key: 'avatar_storage_path')
  final String? profileImageUrl;
  final String? countryCode;
  final DateTime? dateOfBirth;
  final String? address;
  final String? city;
  final CurrencyCode businessCurrency;
}
