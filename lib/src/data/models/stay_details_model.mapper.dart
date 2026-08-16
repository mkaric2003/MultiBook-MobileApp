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
      StayAmenityMapper.ensureInitialized();
      StayRoomModelMapper.ensureInitialized();
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
  static List<StayAmenity> _$amenities(StayDetailsModel v) => v.amenities;
  static const Field<StayDetailsModel, List<StayAmenity>> _f$amenities = Field(
    'amenities',
    _$amenities,
    opt: true,
    def: const [],
  );
  static List<StayRoomModel> _$rooms(StayDetailsModel v) => v.rooms;
  static const Field<StayDetailsModel, List<StayRoomModel>> _f$rooms = Field(
    'rooms',
    _$rooms,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<StayDetailsModel> fields = const {
    #pricePerNight: _f$pricePerNight,
    #amenities: _f$amenities,
    #rooms: _f$rooms,
  };

  static StayDetailsModel _instantiate(DecodingData data) {
    return StayDetailsModel(
      pricePerNight: data.dec(_f$pricePerNight),
      amenities: data.dec(_f$amenities),
      rooms: data.dec(_f$rooms),
    );
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
  ListCopyWith<$R, StayAmenity, ObjectCopyWith<$R, StayAmenity, StayAmenity>>
  get amenities;
  ListCopyWith<
    $R,
    StayRoomModel,
    StayRoomModelCopyWith<$R, StayRoomModel, StayRoomModel>
  >
  get rooms;
  $R call({
    int? pricePerNight,
    List<StayAmenity>? amenities,
    List<StayRoomModel>? rooms,
  });
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
  ListCopyWith<$R, StayAmenity, ObjectCopyWith<$R, StayAmenity, StayAmenity>>
  get amenities => ListCopyWith(
    $value.amenities,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(amenities: v),
  );
  @override
  ListCopyWith<
    $R,
    StayRoomModel,
    StayRoomModelCopyWith<$R, StayRoomModel, StayRoomModel>
  >
  get rooms => ListCopyWith(
    $value.rooms,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(rooms: v),
  );
  @override
  $R call({
    Object? pricePerNight = $none,
    List<StayAmenity>? amenities,
    List<StayRoomModel>? rooms,
  }) => $apply(
    FieldCopyWithData({
      if (pricePerNight != $none) #pricePerNight: pricePerNight,
      if (amenities != null) #amenities: amenities,
      if (rooms != null) #rooms: rooms,
    }),
  );
  @override
  StayDetailsModel $make(CopyWithData data) => StayDetailsModel(
    pricePerNight: data.get(#pricePerNight, or: $value.pricePerNight),
    amenities: data.get(#amenities, or: $value.amenities),
    rooms: data.get(#rooms, or: $value.rooms),
  );

  @override
  StayDetailsModelCopyWith<$R2, StayDetailsModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _StayDetailsModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

