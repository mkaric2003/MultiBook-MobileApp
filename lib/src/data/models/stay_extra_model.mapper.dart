// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'stay_extra_model.dart';

class StayExtraModelMapper extends ClassMapperBase<StayExtraModel> {
  StayExtraModelMapper._();

  static StayExtraModelMapper? _instance;
  static StayExtraModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StayExtraModelMapper._());
      StayExtraTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'StayExtraModel';

  static StayExtraType _$type(StayExtraModel v) => v.type;
  static const Field<StayExtraModel, StayExtraType> _f$type = Field(
    'type',
    _$type,
  );
  static int _$price(StayExtraModel v) => v.price;
  static const Field<StayExtraModel, int> _f$price = Field('price', _$price);
  static bool _$isPerNight(StayExtraModel v) => v.isPerNight;
  static const Field<StayExtraModel, bool> _f$isPerNight = Field(
    'isPerNight',
    _$isPerNight,
    opt: true,
    def: false,
  );
  static bool _$isPerHour(StayExtraModel v) => v.isPerHour;
  static const Field<StayExtraModel, bool> _f$isPerHour = Field(
    'isPerHour',
    _$isPerHour,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<StayExtraModel> fields = const {
    #type: _f$type,
    #price: _f$price,
    #isPerNight: _f$isPerNight,
    #isPerHour: _f$isPerHour,
  };

  static StayExtraModel _instantiate(DecodingData data) {
    return StayExtraModel(
      type: data.dec(_f$type),
      price: data.dec(_f$price),
      isPerNight: data.dec(_f$isPerNight),
      isPerHour: data.dec(_f$isPerHour),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static StayExtraModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StayExtraModel>(map);
  }

  static StayExtraModel fromJson(String json) {
    return ensureInitialized().decodeJson<StayExtraModel>(json);
  }
}

mixin StayExtraModelMappable {
  String toJson() {
    return StayExtraModelMapper.ensureInitialized().encodeJson<StayExtraModel>(
      this as StayExtraModel,
    );
  }

  Map<String, dynamic> toMap() {
    return StayExtraModelMapper.ensureInitialized().encodeMap<StayExtraModel>(
      this as StayExtraModel,
    );
  }

  StayExtraModelCopyWith<StayExtraModel, StayExtraModel, StayExtraModel>
  get copyWith => _StayExtraModelCopyWithImpl<StayExtraModel, StayExtraModel>(
    this as StayExtraModel,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return StayExtraModelMapper.ensureInitialized().stringifyValue(
      this as StayExtraModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return StayExtraModelMapper.ensureInitialized().equalsValue(
      this as StayExtraModel,
      other,
    );
  }

  @override
  int get hashCode {
    return StayExtraModelMapper.ensureInitialized().hashValue(
      this as StayExtraModel,
    );
  }
}

extension StayExtraModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StayExtraModel, $Out> {
  StayExtraModelCopyWith<$R, StayExtraModel, $Out> get $asStayExtraModel =>
      $base.as((v, t, t2) => _StayExtraModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class StayExtraModelCopyWith<$R, $In extends StayExtraModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({StayExtraType? type, int? price, bool? isPerNight, bool? isPerHour});
  StayExtraModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _StayExtraModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StayExtraModel, $Out>
    implements StayExtraModelCopyWith<$R, StayExtraModel, $Out> {
  _StayExtraModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StayExtraModel> $mapper =
      StayExtraModelMapper.ensureInitialized();
  @override
  $R call({
    StayExtraType? type,
    int? price,
    bool? isPerNight,
    bool? isPerHour,
  }) => $apply(
    FieldCopyWithData({
      if (type != null) #type: type,
      if (price != null) #price: price,
      if (isPerNight != null) #isPerNight: isPerNight,
      if (isPerHour != null) #isPerHour: isPerHour,
    }),
  );
  @override
  StayExtraModel $make(CopyWithData data) => StayExtraModel(
    type: data.get(#type, or: $value.type),
    price: data.get(#price, or: $value.price),
    isPerNight: data.get(#isPerNight, or: $value.isPerNight),
    isPerHour: data.get(#isPerHour, or: $value.isPerHour),
  );

  @override
  StayExtraModelCopyWith<$R2, StayExtraModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _StayExtraModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

