// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'stay_room_model.dart';

class StayRoomModelMapper extends ClassMapperBase<StayRoomModel> {
  StayRoomModelMapper._();

  static StayRoomModelMapper? _instance;
  static StayRoomModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StayRoomModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'StayRoomModel';

  static String _$id(StayRoomModel v) => v.id;
  static const Field<StayRoomModel, String> _f$id = Field('id', _$id);
  static String _$name(StayRoomModel v) => v.name;
  static const Field<StayRoomModel, String> _f$name = Field('name', _$name);
  static int _$maxGuests(StayRoomModel v) => v.maxGuests;
  static const Field<StayRoomModel, int> _f$maxGuests = Field(
    'maxGuests',
    _$maxGuests,
  );
  static int _$sizeSquareMeters(StayRoomModel v) => v.sizeSquareMeters;
  static const Field<StayRoomModel, int> _f$sizeSquareMeters = Field(
    'sizeSquareMeters',
    _$sizeSquareMeters,
  );
  static int _$pricePerNight(StayRoomModel v) => v.pricePerNight;
  static const Field<StayRoomModel, int> _f$pricePerNight = Field(
    'pricePerNight',
    _$pricePerNight,
  );
  static int _$quantity(StayRoomModel v) => v.quantity;
  static const Field<StayRoomModel, int> _f$quantity = Field(
    'quantity',
    _$quantity,
    opt: true,
    def: 1,
  );

  @override
  final MappableFields<StayRoomModel> fields = const {
    #id: _f$id,
    #name: _f$name,
    #maxGuests: _f$maxGuests,
    #sizeSquareMeters: _f$sizeSquareMeters,
    #pricePerNight: _f$pricePerNight,
    #quantity: _f$quantity,
  };

  static StayRoomModel _instantiate(DecodingData data) {
    return StayRoomModel(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      maxGuests: data.dec(_f$maxGuests),
      sizeSquareMeters: data.dec(_f$sizeSquareMeters),
      pricePerNight: data.dec(_f$pricePerNight),
      quantity: data.dec(_f$quantity),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static StayRoomModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StayRoomModel>(map);
  }

  static StayRoomModel fromJson(String json) {
    return ensureInitialized().decodeJson<StayRoomModel>(json);
  }
}

mixin StayRoomModelMappable {
  String toJson() {
    return StayRoomModelMapper.ensureInitialized().encodeJson<StayRoomModel>(
      this as StayRoomModel,
    );
  }

  Map<String, dynamic> toMap() {
    return StayRoomModelMapper.ensureInitialized().encodeMap<StayRoomModel>(
      this as StayRoomModel,
    );
  }

  StayRoomModelCopyWith<StayRoomModel, StayRoomModel, StayRoomModel>
  get copyWith => _StayRoomModelCopyWithImpl<StayRoomModel, StayRoomModel>(
    this as StayRoomModel,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return StayRoomModelMapper.ensureInitialized().stringifyValue(
      this as StayRoomModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return StayRoomModelMapper.ensureInitialized().equalsValue(
      this as StayRoomModel,
      other,
    );
  }

  @override
  int get hashCode {
    return StayRoomModelMapper.ensureInitialized().hashValue(
      this as StayRoomModel,
    );
  }
}

extension StayRoomModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StayRoomModel, $Out> {
  StayRoomModelCopyWith<$R, StayRoomModel, $Out> get $asStayRoomModel =>
      $base.as((v, t, t2) => _StayRoomModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class StayRoomModelCopyWith<$R, $In extends StayRoomModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? name,
    int? maxGuests,
    int? sizeSquareMeters,
    int? pricePerNight,
    int? quantity,
  });
  StayRoomModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StayRoomModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StayRoomModel, $Out>
    implements StayRoomModelCopyWith<$R, StayRoomModel, $Out> {
  _StayRoomModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StayRoomModel> $mapper =
      StayRoomModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? name,
    int? maxGuests,
    int? sizeSquareMeters,
    int? pricePerNight,
    int? quantity,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (maxGuests != null) #maxGuests: maxGuests,
      if (sizeSquareMeters != null) #sizeSquareMeters: sizeSquareMeters,
      if (pricePerNight != null) #pricePerNight: pricePerNight,
      if (quantity != null) #quantity: quantity,
    }),
  );
  @override
  StayRoomModel $make(CopyWithData data) => StayRoomModel(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    maxGuests: data.get(#maxGuests, or: $value.maxGuests),
    sizeSquareMeters: data.get(#sizeSquareMeters, or: $value.sizeSquareMeters),
    pricePerNight: data.get(#pricePerNight, or: $value.pricePerNight),
    quantity: data.get(#quantity, or: $value.quantity),
  );

  @override
  StayRoomModelCopyWith<$R2, StayRoomModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _StayRoomModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

