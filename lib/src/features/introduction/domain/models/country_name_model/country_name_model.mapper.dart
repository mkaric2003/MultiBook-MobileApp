// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'country_name_model.dart';

class CountryNameModelMapper extends ClassMapperBase<CountryNameModel> {
  CountryNameModelMapper._();

  static CountryNameModelMapper? _instance;
  static CountryNameModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CountryNameModelMapper._());
      LocalizedNameModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CountryNameModel';

  static String _$common(CountryNameModel v) => v.common;
  static const Field<CountryNameModel, String> _f$common = Field(
    'common',
    _$common,
  );
  static String _$official(CountryNameModel v) => v.official;
  static const Field<CountryNameModel, String> _f$official = Field(
    'official',
    _$official,
  );
  static Map<String, LocalizedNameModel>? _$nativeName(CountryNameModel v) =>
      v.nativeName;
  static const Field<CountryNameModel, Map<String, LocalizedNameModel>>
  _f$nativeName = Field('nativeName', _$nativeName, opt: true);

  @override
  final MappableFields<CountryNameModel> fields = const {
    #common: _f$common,
    #official: _f$official,
    #nativeName: _f$nativeName,
  };

  static CountryNameModel _instantiate(DecodingData data) {
    return CountryNameModel(
      common: data.dec(_f$common),
      official: data.dec(_f$official),
      nativeName: data.dec(_f$nativeName),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CountryNameModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CountryNameModel>(map);
  }

  static CountryNameModel fromJson(String json) {
    return ensureInitialized().decodeJson<CountryNameModel>(json);
  }
}

mixin CountryNameModelMappable {
  String toJson() {
    return CountryNameModelMapper.ensureInitialized()
        .encodeJson<CountryNameModel>(this as CountryNameModel);
  }

  Map<String, dynamic> toMap() {
    return CountryNameModelMapper.ensureInitialized()
        .encodeMap<CountryNameModel>(this as CountryNameModel);
  }

  CountryNameModelCopyWith<CountryNameModel, CountryNameModel, CountryNameModel>
  get copyWith =>
      _CountryNameModelCopyWithImpl<CountryNameModel, CountryNameModel>(
        this as CountryNameModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CountryNameModelMapper.ensureInitialized().stringifyValue(
      this as CountryNameModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return CountryNameModelMapper.ensureInitialized().equalsValue(
      this as CountryNameModel,
      other,
    );
  }

  @override
  int get hashCode {
    return CountryNameModelMapper.ensureInitialized().hashValue(
      this as CountryNameModel,
    );
  }
}

extension CountryNameModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CountryNameModel, $Out> {
  CountryNameModelCopyWith<$R, CountryNameModel, $Out>
  get $asCountryNameModel =>
      $base.as((v, t, t2) => _CountryNameModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CountryNameModelCopyWith<$R, $In extends CountryNameModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<
    $R,
    String,
    LocalizedNameModel,
    LocalizedNameModelCopyWith<$R, LocalizedNameModel, LocalizedNameModel>
  >?
  get nativeName;
  $R call({
    String? common,
    String? official,
    Map<String, LocalizedNameModel>? nativeName,
  });
  CountryNameModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CountryNameModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CountryNameModel, $Out>
    implements CountryNameModelCopyWith<$R, CountryNameModel, $Out> {
  _CountryNameModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CountryNameModel> $mapper =
      CountryNameModelMapper.ensureInitialized();
  @override
  MapCopyWith<
    $R,
    String,
    LocalizedNameModel,
    LocalizedNameModelCopyWith<$R, LocalizedNameModel, LocalizedNameModel>
  >?
  get nativeName => $value.nativeName != null
      ? MapCopyWith(
          $value.nativeName!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(nativeName: v),
        )
      : null;
  @override
  $R call({String? common, String? official, Object? nativeName = $none}) =>
      $apply(
        FieldCopyWithData({
          if (common != null) #common: common,
          if (official != null) #official: official,
          if (nativeName != $none) #nativeName: nativeName,
        }),
      );
  @override
  CountryNameModel $make(CopyWithData data) => CountryNameModel(
    common: data.get(#common, or: $value.common),
    official: data.get(#official, or: $value.official),
    nativeName: data.get(#nativeName, or: $value.nativeName),
  );

  @override
  CountryNameModelCopyWith<$R2, CountryNameModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CountryNameModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

