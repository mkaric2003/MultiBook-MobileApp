// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'localized_model.dart';

class LocalizedNameModelMapper extends ClassMapperBase<LocalizedNameModel> {
  LocalizedNameModelMapper._();

  static LocalizedNameModelMapper? _instance;
  static LocalizedNameModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalizedNameModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LocalizedNameModel';

  static String _$official(LocalizedNameModel v) => v.official;
  static const Field<LocalizedNameModel, String> _f$official = Field(
    'official',
    _$official,
  );
  static String _$common(LocalizedNameModel v) => v.common;
  static const Field<LocalizedNameModel, String> _f$common = Field(
    'common',
    _$common,
  );

  @override
  final MappableFields<LocalizedNameModel> fields = const {
    #official: _f$official,
    #common: _f$common,
  };

  static LocalizedNameModel _instantiate(DecodingData data) {
    return LocalizedNameModel(
      official: data.dec(_f$official),
      common: data.dec(_f$common),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalizedNameModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalizedNameModel>(map);
  }

  static LocalizedNameModel fromJson(String json) {
    return ensureInitialized().decodeJson<LocalizedNameModel>(json);
  }
}

mixin LocalizedNameModelMappable {
  String toJson() {
    return LocalizedNameModelMapper.ensureInitialized()
        .encodeJson<LocalizedNameModel>(this as LocalizedNameModel);
  }

  Map<String, dynamic> toMap() {
    return LocalizedNameModelMapper.ensureInitialized()
        .encodeMap<LocalizedNameModel>(this as LocalizedNameModel);
  }

  LocalizedNameModelCopyWith<
    LocalizedNameModel,
    LocalizedNameModel,
    LocalizedNameModel
  >
  get copyWith =>
      _LocalizedNameModelCopyWithImpl<LocalizedNameModel, LocalizedNameModel>(
        this as LocalizedNameModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return LocalizedNameModelMapper.ensureInitialized().stringifyValue(
      this as LocalizedNameModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalizedNameModelMapper.ensureInitialized().equalsValue(
      this as LocalizedNameModel,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalizedNameModelMapper.ensureInitialized().hashValue(
      this as LocalizedNameModel,
    );
  }
}

extension LocalizedNameModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalizedNameModel, $Out> {
  LocalizedNameModelCopyWith<$R, LocalizedNameModel, $Out>
  get $asLocalizedNameModel => $base.as(
    (v, t, t2) => _LocalizedNameModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LocalizedNameModelCopyWith<
  $R,
  $In extends LocalizedNameModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? official, String? common});
  LocalizedNameModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalizedNameModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalizedNameModel, $Out>
    implements LocalizedNameModelCopyWith<$R, LocalizedNameModel, $Out> {
  _LocalizedNameModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalizedNameModel> $mapper =
      LocalizedNameModelMapper.ensureInitialized();
  @override
  $R call({String? official, String? common}) => $apply(
    FieldCopyWithData({
      if (official != null) #official: official,
      if (common != null) #common: common,
    }),
  );
  @override
  LocalizedNameModel $make(CopyWithData data) => LocalizedNameModel(
    official: data.get(#official, or: $value.official),
    common: data.get(#common, or: $value.common),
  );

  @override
  LocalizedNameModelCopyWith<$R2, LocalizedNameModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LocalizedNameModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

