// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'country_model.dart';

class CountryModelMapper extends ClassMapperBase<CountryModel> {
  CountryModelMapper._();

  static CountryModelMapper? _instance;
  static CountryModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CountryModelMapper._());
      CountryNameModelMapper.ensureInitialized();
      CurrencyModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CountryModel';

  static CountryNameModel _$name(CountryModel v) => v.name;
  static const Field<CountryModel, CountryNameModel> _f$name = Field(
    'name',
    _$name,
  );
  static List<String>? _$capital(CountryModel v) => v.capital;
  static const Field<CountryModel, List<String>> _f$capital = Field(
    'capital',
    _$capital,
    opt: true,
  );
  static double? _$area(CountryModel v) => v.area;
  static const Field<CountryModel, double> _f$area = Field(
    'area',
    _$area,
    opt: true,
  );
  static Map<String, CurrencyModel>? _$currencies(CountryModel v) =>
      v.currencies;
  static const Field<CountryModel, Map<String, CurrencyModel>> _f$currencies =
      Field('currencies', _$currencies, opt: true);
  static Map<String, String>? _$languages(CountryModel v) => v.languages;
  static const Field<CountryModel, Map<String, String>> _f$languages = Field(
    'languages',
    _$languages,
    opt: true,
  );

  @override
  final MappableFields<CountryModel> fields = const {
    #name: _f$name,
    #capital: _f$capital,
    #area: _f$area,
    #currencies: _f$currencies,
    #languages: _f$languages,
  };

  static CountryModel _instantiate(DecodingData data) {
    return CountryModel(
      name: data.dec(_f$name),
      capital: data.dec(_f$capital),
      area: data.dec(_f$area),
      currencies: data.dec(_f$currencies),
      languages: data.dec(_f$languages),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CountryModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CountryModel>(map);
  }

  static CountryModel fromJson(String json) {
    return ensureInitialized().decodeJson<CountryModel>(json);
  }
}

mixin CountryModelMappable {
  String toJson() {
    return CountryModelMapper.ensureInitialized().encodeJson<CountryModel>(
      this as CountryModel,
    );
  }

  Map<String, dynamic> toMap() {
    return CountryModelMapper.ensureInitialized().encodeMap<CountryModel>(
      this as CountryModel,
    );
  }

  CountryModelCopyWith<CountryModel, CountryModel, CountryModel> get copyWith =>
      _CountryModelCopyWithImpl<CountryModel, CountryModel>(
        this as CountryModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CountryModelMapper.ensureInitialized().stringifyValue(
      this as CountryModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return CountryModelMapper.ensureInitialized().equalsValue(
      this as CountryModel,
      other,
    );
  }

  @override
  int get hashCode {
    return CountryModelMapper.ensureInitialized().hashValue(
      this as CountryModel,
    );
  }
}

extension CountryModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CountryModel, $Out> {
  CountryModelCopyWith<$R, CountryModel, $Out> get $asCountryModel =>
      $base.as((v, t, t2) => _CountryModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CountryModelCopyWith<$R, $In extends CountryModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CountryNameModelCopyWith<$R, CountryNameModel, CountryNameModel> get name;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get capital;
  MapCopyWith<
    $R,
    String,
    CurrencyModel,
    CurrencyModelCopyWith<$R, CurrencyModel, CurrencyModel>
  >?
  get currencies;
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>?
  get languages;
  $R call({
    CountryNameModel? name,
    List<String>? capital,
    double? area,
    Map<String, CurrencyModel>? currencies,
    Map<String, String>? languages,
  });
  CountryModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CountryModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CountryModel, $Out>
    implements CountryModelCopyWith<$R, CountryModel, $Out> {
  _CountryModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CountryModel> $mapper =
      CountryModelMapper.ensureInitialized();
  @override
  CountryNameModelCopyWith<$R, CountryNameModel, CountryNameModel> get name =>
      $value.name.copyWith.$chain((v) => call(name: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get capital =>
      $value.capital != null
      ? ListCopyWith(
          $value.capital!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(capital: v),
        )
      : null;
  @override
  MapCopyWith<
    $R,
    String,
    CurrencyModel,
    CurrencyModelCopyWith<$R, CurrencyModel, CurrencyModel>
  >?
  get currencies => $value.currencies != null
      ? MapCopyWith(
          $value.currencies!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(currencies: v),
        )
      : null;
  @override
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>?
  get languages => $value.languages != null
      ? MapCopyWith(
          $value.languages!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(languages: v),
        )
      : null;
  @override
  $R call({
    CountryNameModel? name,
    Object? capital = $none,
    Object? area = $none,
    Object? currencies = $none,
    Object? languages = $none,
  }) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (capital != $none) #capital: capital,
      if (area != $none) #area: area,
      if (currencies != $none) #currencies: currencies,
      if (languages != $none) #languages: languages,
    }),
  );
  @override
  CountryModel $make(CopyWithData data) => CountryModel(
    name: data.get(#name, or: $value.name),
    capital: data.get(#capital, or: $value.capital),
    area: data.get(#area, or: $value.area),
    currencies: data.get(#currencies, or: $value.currencies),
    languages: data.get(#languages, or: $value.languages),
  );

  @override
  CountryModelCopyWith<$R2, CountryModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CountryModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

