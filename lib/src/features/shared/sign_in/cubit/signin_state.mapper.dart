// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'signin_state.dart';

class SigninStateMapper extends ClassMapperBase<SigninState> {
  SigninStateMapper._();

  static SigninStateMapper? _instance;
  static SigninStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SigninStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SigninState';

  static bool _$isLoading(SigninState v) => v.isLoading;
  static const Field<SigninState, bool> _f$isLoading = Field(
    'isLoading',
    _$isLoading,
    opt: true,
    def: false,
  );
  static bool _$isSuccess(SigninState v) => v.isSuccess;
  static const Field<SigninState, bool> _f$isSuccess = Field(
    'isSuccess',
    _$isSuccess,
    opt: true,
    def: false,
  );
  static String? _$errorMessage(SigninState v) => v.errorMessage;
  static const Field<SigninState, String> _f$errorMessage = Field(
    'errorMessage',
    _$errorMessage,
    opt: true,
  );
  static String? _$successMessage(SigninState v) => v.successMessage;
  static const Field<SigninState, String> _f$successMessage = Field(
    'successMessage',
    _$successMessage,
    opt: true,
  );

  @override
  final MappableFields<SigninState> fields = const {
    #isLoading: _f$isLoading,
    #isSuccess: _f$isSuccess,
    #errorMessage: _f$errorMessage,
    #successMessage: _f$successMessage,
  };

  static SigninState _instantiate(DecodingData data) {
    return SigninState(
      isLoading: data.dec(_f$isLoading),
      isSuccess: data.dec(_f$isSuccess),
      errorMessage: data.dec(_f$errorMessage),
      successMessage: data.dec(_f$successMessage),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SigninState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SigninState>(map);
  }

  static SigninState fromJson(String json) {
    return ensureInitialized().decodeJson<SigninState>(json);
  }
}

mixin SigninStateMappable {
  String toJson() {
    return SigninStateMapper.ensureInitialized().encodeJson<SigninState>(
      this as SigninState,
    );
  }

  Map<String, dynamic> toMap() {
    return SigninStateMapper.ensureInitialized().encodeMap<SigninState>(
      this as SigninState,
    );
  }

  SigninStateCopyWith<SigninState, SigninState, SigninState> get copyWith =>
      _SigninStateCopyWithImpl<SigninState, SigninState>(
        this as SigninState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SigninStateMapper.ensureInitialized().stringifyValue(
      this as SigninState,
    );
  }

  @override
  bool operator ==(Object other) {
    return SigninStateMapper.ensureInitialized().equalsValue(
      this as SigninState,
      other,
    );
  }

  @override
  int get hashCode {
    return SigninStateMapper.ensureInitialized().hashValue(this as SigninState);
  }
}

extension SigninStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SigninState, $Out> {
  SigninStateCopyWith<$R, SigninState, $Out> get $asSigninState =>
      $base.as((v, t, t2) => _SigninStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SigninStateCopyWith<$R, $In extends SigninState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    String? successMessage,
  });
  SigninStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SigninStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SigninState, $Out>
    implements SigninStateCopyWith<$R, SigninState, $Out> {
  _SigninStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SigninState> $mapper =
      SigninStateMapper.ensureInitialized();
  @override
  $R call({
    bool? isLoading,
    bool? isSuccess,
    Object? errorMessage = $none,
    Object? successMessage = $none,
  }) => $apply(
    FieldCopyWithData({
      if (isLoading != null) #isLoading: isLoading,
      if (isSuccess != null) #isSuccess: isSuccess,
      if (errorMessage != $none) #errorMessage: errorMessage,
      if (successMessage != $none) #successMessage: successMessage,
    }),
  );
  @override
  SigninState $make(CopyWithData data) => SigninState(
    isLoading: data.get(#isLoading, or: $value.isLoading),
    isSuccess: data.get(#isSuccess, or: $value.isSuccess),
    errorMessage: data.get(#errorMessage, or: $value.errorMessage),
    successMessage: data.get(#successMessage, or: $value.successMessage),
  );

  @override
  SigninStateCopyWith<$R2, SigninState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SigninStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

