// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'stay_details_model.dart';

class StayDetailsModelMapper extends ClassMapperBase<StayDetailsModel> {
  StayDetailsModelMapper._();

  static StayDetailsModelMapper? _instance;
  static StayDetailsModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StayDetailsModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'StayDetailsModel';

  static int? _$pricePerNight(StayDetailsModel v) => v.pricePerNight;
  static const Field<StayDetailsModel, int> _f$pricePerNight = Field(
    'pricePerNight',
    _$pricePerNight,
    opt: true,
  );

  @override
  final MappableFields<StayDetailsModel> fields = const {
    #pricePerNight: _f$pricePerNight,
  };

  static StayDetailsModel _instantiate(DecodingData data) {
    return StayDetailsModel(pricePerNight: data.dec(_f$pricePerNight));
  }

  @override
  final Function instantiate = _instantiate;

  static StayDetailsModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StayDetailsModel>(map);
  }

  static StayDetailsModel fromJson(String json) {
    return ensureInitialized().decodeJson<StayDetailsModel>(json);
  }
}

mixin StayDetailsModelMappable {
  String toJson() {
    return StayDetailsModelMapper.ensureInitialized()
        .encodeJson<StayDetailsModel>(this as StayDetailsModel);
  }

  Map<String, dynamic> toMap() {
    return StayDetailsModelMapper.ensureInitialized()
        .encodeMap<StayDetailsModel>(this as StayDetailsModel);
  }

  StayDetailsModelCopyWith<StayDetailsModel, StayDetailsModel, StayDetailsModel>
  get copyWith =>
      _StayDetailsModelCopyWithImpl<StayDetailsModel, StayDetailsModel>(
        this as StayDetailsModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return StayDetailsModelMapper.ensureInitialized().stringifyValue(
      this as StayDetailsModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return StayDetailsModelMapper.ensureInitialized().equalsValue(
      this as StayDetailsModel,
      other,
    );
  }

  @override
  int get hashCode {
    return StayDetailsModelMapper.ensureInitialized().hashValue(
      this as StayDetailsModel,
    );
  }
}

extension StayDetailsModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StayDetailsModel, $Out> {
  StayDetailsModelCopyWith<$R, StayDetailsModel, $Out>
  get $asStayDetailsModel =>
      $base.as((v, t, t2) => _StayDetailsModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class StayDetailsModelCopyWith<$R, $In extends StayDetailsModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? pricePerNight});
  StayDetailsModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _StayDetailsModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StayDetailsModel, $Out>
    implements StayDetailsModelCopyWith<$R, StayDetailsModel, $Out> {
  _StayDetailsModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StayDetailsModel> $mapper =
      StayDetailsModelMapper.ensureInitialized();
  @override
  $R call({Object? pricePerNight = $none}) => $apply(
    FieldCopyWithData({
      if (pricePerNight != $none) #pricePerNight: pricePerNight,
    }),
  );
  @override
  StayDetailsModel $make(CopyWithData data) => StayDetailsModel(
    pricePerNight: data.get(#pricePerNight, or: $value.pricePerNight),
  );

  @override
  StayDetailsModelCopyWith<$R2, StayDetailsModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _StayDetailsModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

