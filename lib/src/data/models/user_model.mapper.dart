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

  @override
  final MappableFields<UserModel> fields = const {
    #id: _f$id,
    #firstName: _f$firstName,
    #lastName: _f$lastName,
    #fullName: _f$fullName,
    #email: _f$email,
    #type: _f$type,
    #selectedBusinessId: _f$selectedBusinessId,
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
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (firstName != null) #firstName: firstName,
      if (lastName != null) #lastName: lastName,
      if (fullName != null) #fullName: fullName,
      if (email != null) #email: email,
      if (type != null) #type: type,
      if (selectedBusinessId != $none) #selectedBusinessId: selectedBusinessId,
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
  );

  @override
  UserModelCopyWith<$R2, UserModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

