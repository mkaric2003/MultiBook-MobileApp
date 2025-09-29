// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'currency_model.dart';

class CurrencyModelMapper extends ClassMapperBase<CurrencyModel> {
  CurrencyModelMapper._();

  static CurrencyModelMapper? _instance;
  static CurrencyModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CurrencyModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CurrencyModel';

  static String _$name(CurrencyModel v) => v.name;
  static const Field<CurrencyModel, String> _f$name = Field('name', _$name);
  static String? _$symbol(CurrencyModel v) => v.symbol;
  static const Field<CurrencyModel, String> _f$symbol = Field(
    'symbol',
    _$symbol,
    opt: true,
  );

  @override
  final MappableFields<CurrencyModel> fields = const {
    #name: _f$name,
    #symbol: _f$symbol,
  };

  static CurrencyModel _instantiate(DecodingData data) {
    return CurrencyModel(name: data.dec(_f$name), symbol: data.dec(_f$symbol));
  }

  @override
  final Function instantiate = _instantiate;

  static CurrencyModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CurrencyModel>(map);
  }

  static CurrencyModel fromJson(String json) {
    return ensureInitialized().decodeJson<CurrencyModel>(json);
  }
}

mixin CurrencyModelMappable {
  String toJson() {
    return CurrencyModelMapper.ensureInitialized().encodeJson<CurrencyModel>(
      this as CurrencyModel,
    );
  }

  Map<String, dynamic> toMap() {
    return CurrencyModelMapper.ensureInitialized().encodeMap<CurrencyModel>(
      this as CurrencyModel,
    );
  }

  CurrencyModelCopyWith<CurrencyModel, CurrencyModel, CurrencyModel>
  get copyWith => _CurrencyModelCopyWithImpl<CurrencyModel, CurrencyModel>(
    this as CurrencyModel,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return CurrencyModelMapper.ensureInitialized().stringifyValue(
      this as CurrencyModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return CurrencyModelMapper.ensureInitialized().equalsValue(
      this as CurrencyModel,
      other,
    );
  }

  @override
  int get hashCode {
    return CurrencyModelMapper.ensureInitialized().hashValue(
      this as CurrencyModel,
    );
  }
}

extension CurrencyModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CurrencyModel, $Out> {
  CurrencyModelCopyWith<$R, CurrencyModel, $Out> get $asCurrencyModel =>
      $base.as((v, t, t2) => _CurrencyModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CurrencyModelCopyWith<$R, $In extends CurrencyModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? symbol});
  CurrencyModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CurrencyModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CurrencyModel, $Out>
    implements CurrencyModelCopyWith<$R, CurrencyModel, $Out> {
  _CurrencyModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CurrencyModel> $mapper =
      CurrencyModelMapper.ensureInitialized();
  @override
  $R call({String? name, Object? symbol = $none}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (symbol != $none) #symbol: symbol,
    }),
  );
  @override
  CurrencyModel $make(CopyWithData data) => CurrencyModel(
    name: data.get(#name, or: $value.name),
    symbol: data.get(#symbol, or: $value.symbol),
  );

  @override
  CurrencyModelCopyWith<$R2, CurrencyModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CurrencyModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

