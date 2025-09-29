// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'countries_state.dart';

class CountriesStateMapper extends ClassMapperBase<CountriesState> {
  CountriesStateMapper._();

  static CountriesStateMapper? _instance;
  static CountriesStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CountriesStateMapper._());
      CountryModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CountriesState';

  static bool _$isLoading(CountriesState v) => v.isLoading;
  static const Field<CountriesState, bool> _f$isLoading = Field(
    'isLoading',
    _$isLoading,
    opt: true,
    def: false,
  );
  static List<CountryModel> _$countries(CountriesState v) => v.countries;
  static const Field<CountriesState, List<CountryModel>> _f$countries = Field(
    'countries',
    _$countries,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<CountriesState> fields = const {
    #isLoading: _f$isLoading,
    #countries: _f$countries,
  };

  static CountriesState _instantiate(DecodingData data) {
    return CountriesState(
      isLoading: data.dec(_f$isLoading),
      countries: data.dec(_f$countries),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CountriesState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CountriesState>(map);
  }

  static CountriesState fromJson(String json) {
    return ensureInitialized().decodeJson<CountriesState>(json);
  }
}

mixin CountriesStateMappable {
  String toJson() {
    return CountriesStateMapper.ensureInitialized().encodeJson<CountriesState>(
      this as CountriesState,
    );
  }

  Map<String, dynamic> toMap() {
    return CountriesStateMapper.ensureInitialized().encodeMap<CountriesState>(
      this as CountriesState,
    );
  }

  CountriesStateCopyWith<CountriesState, CountriesState, CountriesState>
  get copyWith => _CountriesStateCopyWithImpl<CountriesState, CountriesState>(
    this as CountriesState,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return CountriesStateMapper.ensureInitialized().stringifyValue(
      this as CountriesState,
    );
  }

  @override
  bool operator ==(Object other) {
    return CountriesStateMapper.ensureInitialized().equalsValue(
      this as CountriesState,
      other,
    );
  }

  @override
  int get hashCode {
    return CountriesStateMapper.ensureInitialized().hashValue(
      this as CountriesState,
    );
  }
}

extension CountriesStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CountriesState, $Out> {
  CountriesStateCopyWith<$R, CountriesState, $Out> get $asCountriesState =>
      $base.as((v, t, t2) => _CountriesStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CountriesStateCopyWith<$R, $In extends CountriesState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    CountryModel,
    CountryModelCopyWith<$R, CountryModel, CountryModel>
  >
  get countries;
  $R call({bool? isLoading, List<CountryModel>? countries});
  CountriesStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CountriesStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CountriesState, $Out>
    implements CountriesStateCopyWith<$R, CountriesState, $Out> {
  _CountriesStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CountriesState> $mapper =
      CountriesStateMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    CountryModel,
    CountryModelCopyWith<$R, CountryModel, CountryModel>
  >
  get countries => ListCopyWith(
    $value.countries,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(countries: v),
  );
  @override
  $R call({bool? isLoading, List<CountryModel>? countries}) => $apply(
    FieldCopyWithData({
      if (isLoading != null) #isLoading: isLoading,
      if (countries != null) #countries: countries,
    }),
  );
  @override
  CountriesState $make(CopyWithData data) => CountriesState(
    isLoading: data.get(#isLoading, or: $value.isLoading),
    countries: data.get(#countries, or: $value.countries),
  );

  @override
  CountriesStateCopyWith<$R2, CountriesState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CountriesStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

