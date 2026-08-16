// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'signup_state.dart';

class SignupStateMapper extends ClassMapperBase<SignupState> {
  SignupStateMapper._();

  static SignupStateMapper? _instance;
  static SignupStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SignupStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SignupState';

  static bool _$isLoading(SignupState v) => v.isLoading;
  static const Field<SignupState, bool> _f$isLoading = Field(
    'isLoading',
    _$isLoading,
    opt: true,
    def: false,
  );
  static bool _$isSuccess(SignupState v) => v.isSuccess;
  static const Field<SignupState, bool> _f$isSuccess = Field(
    'isSuccess',
    _$isSuccess,
    opt: true,
    def: false,
  );
  static bool _$requiresUserTypeSelection(SignupState v) =>
      v.requiresUserTypeSelection;
  static const Field<SignupState, bool> _f$requiresUserTypeSelection = Field(
    'requiresUserTypeSelection',
    _$requiresUserTypeSelection,
    opt: true,
    def: false,
  );
  static String? _$errorMessage(SignupState v) => v.errorMessage;
  static const Field<SignupState, String> _f$errorMessage = Field(
    'errorMessage',
    _$errorMessage,
    opt: true,
  );

  @override
  final MappableFields<SignupState> fields = const {
    #isLoading: _f$isLoading,
    #isSuccess: _f$isSuccess,
    #requiresUserTypeSelection: _f$requiresUserTypeSelection,
    #errorMessage: _f$errorMessage,
  };

  static SignupState _instantiate(DecodingData data) {
    return SignupState(
      isLoading: data.dec(_f$isLoading),
      isSuccess: data.dec(_f$isSuccess),
      requiresUserTypeSelection: data.dec(_f$requiresUserTypeSelection),
      errorMessage: data.dec(_f$errorMessage),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SignupState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SignupState>(map);
  }

  static SignupState fromJson(String json) {
    return ensureInitialized().decodeJson<SignupState>(json);
  }
}

mixin SignupStateMappable {
  String toJson() {
    return SignupStateMapper.ensureInitialized().encodeJson<SignupState>(
      this as SignupState,
    );
  }

  Map<String, dynamic> toMap() {
    return SignupStateMapper.ensureInitialized().encodeMap<SignupState>(
      this as SignupState,
    );
  }

  SignupStateCopyWith<SignupState, SignupState, SignupState> get copyWith =>
      _SignupStateCopyWithImpl<SignupState, SignupState>(
        this as SignupState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SignupStateMapper.ensureInitialized().stringifyValue(
      this as SignupState,
    );
  }

  @override
  bool operator ==(Object other) {
    return SignupStateMapper.ensureInitialized().equalsValue(
      this as SignupState,
      other,
    );
  }

  @override
  int get hashCode {
    return SignupStateMapper.ensureInitialized().hashValue(this as SignupState);
  }
}

extension SignupStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SignupState, $Out> {
  SignupStateCopyWith<$R, SignupState, $Out> get $asSignupState =>
      $base.as((v, t, t2) => _SignupStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SignupStateCopyWith<$R, $In extends SignupState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    bool? isLoading,
    bool? isSuccess,
    bool? requiresUserTypeSelection,
    String? errorMessage,
  });
  SignupStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SignupStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SignupState, $Out>
    implements SignupStateCopyWith<$R, SignupState, $Out> {
  _SignupStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SignupState> $mapper =
      SignupStateMapper.ensureInitialized();
  @override
  $R call({
    bool? isLoading,
    bool? isSuccess,
    bool? requiresUserTypeSelection,
    Object? errorMessage = $none,
  }) => $apply(
    FieldCopyWithData({
      if (isLoading != null) #isLoading: isLoading,
      if (isSuccess != null) #isSuccess: isSuccess,
      if (requiresUserTypeSelection != null)
        #requiresUserTypeSelection: requiresUserTypeSelection,
      if (errorMessage != $none) #errorMessage: errorMessage,
    }),
  );
  @override
  SignupState $make(CopyWithData data) => SignupState(
    isLoading: data.get(#isLoading, or: $value.isLoading),
    isSuccess: data.get(#isSuccess, or: $value.isSuccess),
    requiresUserTypeSelection: data.get(
      #requiresUserTypeSelection,
      or: $value.requiresUserTypeSelection,
    ),
    errorMessage: data.get(#errorMessage, or: $value.errorMessage),
  );

  @override
  SignupStateCopyWith<$R2, SignupState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SignupStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

