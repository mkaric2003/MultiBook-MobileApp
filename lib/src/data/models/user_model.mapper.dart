// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_model.dart';

class UserModelMapper extends ClassMapperBase<UserModel> {
  UserModelMapper._();

  static UserModelMapper? _instance;
  static UserModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserModelMapper._());
      UserTypeMapper.ensureInitialized();
      CurrencyCodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UserModel';

  static String _$id(UserModel v) => v.id;
  static const Field<UserModel, String> _f$id = Field('id', _$id);
  static String _$firstName(UserModel v) => v.firstName;
  static const Field<UserModel, String> _f$firstName = Field(
    'firstName',
    _$firstName,
  );
  static String _$lastName(UserModel v) => v.lastName;
  static const Field<UserModel, String> _f$lastName = Field(
    'lastName',
    _$lastName,
  );
  static String _$fullName(UserModel v) => v.fullName;
  static const Field<UserModel, String> _f$fullName = Field(
    'fullName',
    _$fullName,
  );
  static String _$email(UserModel v) => v.email;
  static const Field<UserModel, String> _f$email = Field('email', _$email);
  static UserType _$type(UserModel v) => v.type;
  static const Field<UserModel, UserType> _f$type = Field(
    'type',
    _$type,
    opt: true,
    def: UserType.provider,
  );
  static String? _$selectedBusinessId(UserModel v) => v.selectedBusinessId;
  static const Field<UserModel, String> _f$selectedBusinessId = Field(
    'selectedBusinessId',
    _$selectedBusinessId,
    opt: true,
  );
  static String? _$phoneNumber(UserModel v) => v.phoneNumber;
  static const Field<UserModel, String> _f$phoneNumber = Field(
    'phoneNumber',
    _$phoneNumber,
    opt: true,
  );
  static String? _$profileImageUrl(UserModel v) => v.profileImageUrl;
  static const Field<UserModel, String> _f$profileImageUrl = Field(
    'profileImageUrl',
    _$profileImageUrl,
    opt: true,
  );
  static String? _$countryCode(UserModel v) => v.countryCode;
  static const Field<UserModel, String> _f$countryCode = Field(
    'countryCode',
    _$countryCode,
    opt: true,
  );
  static DateTime? _$dateOfBirth(UserModel v) => v.dateOfBirth;
  static const Field<UserModel, DateTime> _f$dateOfBirth = Field(
    'dateOfBirth',
    _$dateOfBirth,
    opt: true,
  );
  static String? _$address(UserModel v) => v.address;
  static const Field<UserModel, String> _f$address = Field(
    'address',
    _$address,
    opt: true,
  );
  static String? _$city(UserModel v) => v.city;
  static const Field<UserModel, String> _f$city = Field(
    'city',
    _$city,
    opt: true,
  );
  static CurrencyCode _$businessCurrency(UserModel v) => v.businessCurrency;
  static const Field<UserModel, CurrencyCode> _f$businessCurrency = Field(
    'businessCurrency',
    _$businessCurrency,
    opt: true,
    def: CurrencyCode.bam,
  );

  @override
  final MappableFields<UserModel> fields = const {
    #id: _f$id,
    #firstName: _f$firstName,
    #lastName: _f$lastName,
    #fullName: _f$fullName,
    #email: _f$email,
    #type: _f$type,
    #selectedBusinessId: _f$selectedBusinessId,
    #phoneNumber: _f$phoneNumber,
    #profileImageUrl: _f$profileImageUrl,
    #countryCode: _f$countryCode,
    #dateOfBirth: _f$dateOfBirth,
    #address: _f$address,
    #city: _f$city,
    #businessCurrency: _f$businessCurrency,
  };

  static UserModel _instantiate(DecodingData data) {
    return UserModel(
      id: data.dec(_f$id),
      firstName: data.dec(_f$firstName),
      lastName: data.dec(_f$lastName),
      fullName: data.dec(_f$fullName),
      email: data.dec(_f$email),
      type: data.dec(_f$type),
      selectedBusinessId: data.dec(_f$selectedBusinessId),
      phoneNumber: data.dec(_f$phoneNumber),
      profileImageUrl: data.dec(_f$profileImageUrl),
      countryCode: data.dec(_f$countryCode),
      dateOfBirth: data.dec(_f$dateOfBirth),
      address: data.dec(_f$address),
      city: data.dec(_f$city),
      businessCurrency: data.dec(_f$businessCurrency),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static UserModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserModel>(map);
  }

  static UserModel fromJson(String json) {
    return ensureInitialized().decodeJson<UserModel>(json);
  }
}

mixin UserModelMappable {
  String toJson() {
    return UserModelMapper.ensureInitialized().encodeJson<UserModel>(
      this as UserModel,
    );
  }

  Map<String, dynamic> toMap() {
    return UserModelMapper.ensureInitialized().encodeMap<UserModel>(
      this as UserModel,
    );
  }

  UserModelCopyWith<UserModel, UserModel, UserModel> get copyWith =>
      _UserModelCopyWithImpl<UserModel, UserModel>(
        this as UserModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return UserModelMapper.ensureInitialized().stringifyValue(
      this as UserModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserModelMapper.ensureInitialized().equalsValue(
      this as UserModel,
      other,
    );
  }

  @override
  int get hashCode {
    return UserModelMapper.ensureInitialized().hashValue(this as UserModel);
  }
}

extension UserModelValueCopy<$R, $Out> on ObjectCopyWith<$R, UserModel, $Out> {
  UserModelCopyWith<$R, UserModel, $Out> get $asUserModel =>
      $base.as((v, t, t2) => _UserModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserModelCopyWith<$R, $In extends UserModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? firstName,
    String? lastName,
    String? fullName,
    String? email,
    UserType? type,
    String? selectedBusinessId,
    String? phoneNumber,
    String? profileImageUrl,
    String? countryCode,
    DateTime? dateOfBirth,
    String? address,
    String? city,
    CurrencyCode? businessCurrency,
  });
  UserModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserModel, $Out>
    implements UserModelCopyWith<$R, UserModel, $Out> {
  _UserModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserModel> $mapper =
      UserModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? firstName,
    String? lastName,
    String? fullName,
    String? email,
    UserType? type,
    Object? selectedBusinessId = $none,
    Object? phoneNumber = $none,
    Object? profileImageUrl = $none,
    Object? countryCode = $none,
    Object? dateOfBirth = $none,
    Object? address = $none,
    Object? city = $none,
    CurrencyCode? businessCurrency,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (firstName != null) #firstName: firstName,
      if (lastName != null) #lastName: lastName,
      if (fullName != null) #fullName: fullName,
      if (email != null) #email: email,
      if (type != null) #type: type,
      if (selectedBusinessId != $none) #selectedBusinessId: selectedBusinessId,
      if (phoneNumber != $none) #phoneNumber: phoneNumber,
      if (profileImageUrl != $none) #profileImageUrl: profileImageUrl,
      if (countryCode != $none) #countryCode: countryCode,
      if (dateOfBirth != $none) #dateOfBirth: dateOfBirth,
      if (address != $none) #address: address,
      if (city != $none) #city: city,
      if (businessCurrency != null) #businessCurrency: businessCurrency,
    }),
  );
  @override
  UserModel $make(CopyWithData data) => UserModel(
    id: data.get(#id, or: $value.id),
    firstName: data.get(#firstName, or: $value.firstName),
    lastName: data.get(#lastName, or: $value.lastName),
    fullName: data.get(#fullName, or: $value.fullName),
    email: data.get(#email, or: $value.email),
    type: data.get(#type, or: $value.type),
    selectedBusinessId: data.get(
      #selectedBusinessId,
      or: $value.selectedBusinessId,
    ),
    phoneNumber: data.get(#phoneNumber, or: $value.phoneNumber),
    profileImageUrl: data.get(#profileImageUrl, or: $value.profileImageUrl),
    countryCode: data.get(#countryCode, or: $value.countryCode),
    dateOfBirth: data.get(#dateOfBirth, or: $value.dateOfBirth),
    address: data.get(#address, or: $value.address),
    city: data.get(#city, or: $value.city),
    businessCurrency: data.get(#businessCurrency, or: $value.businessCurrency),
  );

  @override
  UserModelCopyWith<$R2, UserModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

