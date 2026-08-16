// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'stay_booking_model.dart';

class StayBookingModelMapper extends ClassMapperBase<StayBookingModel> {
  StayBookingModelMapper._();

  static StayBookingModelMapper? _instance;
  static StayBookingModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StayBookingModelMapper._());
      StayBookingStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'StayBookingModel';

  static String _$id(StayBookingModel v) => v.id;
  static const Field<StayBookingModel, String> _f$id = Field('id', _$id);
  static String _$businessId(StayBookingModel v) => v.businessId;
  static const Field<StayBookingModel, String> _f$businessId = Field(
    'businessId',
    _$businessId,
  );
  static String _$userId(StayBookingModel v) => v.userId;
  static const Field<StayBookingModel, String> _f$userId = Field(
    'userId',
    _$userId,
  );
  static DateTime _$checkIn(StayBookingModel v) => v.checkIn;
  static const Field<StayBookingModel, DateTime> _f$checkIn = Field(
    'checkIn',
    _$checkIn,
  );
  static DateTime _$checkOut(StayBookingModel v) => v.checkOut;
  static const Field<StayBookingModel, DateTime> _f$checkOut = Field(
    'checkOut',
    _$checkOut,
  );
  static int _$adults(StayBookingModel v) => v.adults;
  static const Field<StayBookingModel, int> _f$adults = Field(
    'adults',
    _$adults,
  );
  static int _$children(StayBookingModel v) => v.children;
  static const Field<StayBookingModel, int> _f$children = Field(
    'children',
    _$children,
    opt: true,
    def: 0,
  );
  static String? _$unitId(StayBookingModel v) => v.unitId;
  static const Field<StayBookingModel, String> _f$unitId = Field(
    'unitId',
    _$unitId,
    opt: true,
  );
  static double _$totalPrice(StayBookingModel v) => v.totalPrice;
  static const Field<StayBookingModel, double> _f$totalPrice = Field(
    'totalPrice',
    _$totalPrice,
  );
  static String _$currency(StayBookingModel v) => v.currency;
  static const Field<StayBookingModel, String> _f$currency = Field(
    'currency',
    _$currency,
  );
  static StayBookingStatus _$status(StayBookingModel v) => v.status;
  static const Field<StayBookingModel, StayBookingStatus> _f$status = Field(
    'status',
    _$status,
    opt: true,
    def: StayBookingStatus.pending,
  );
  static String? _$note(StayBookingModel v) => v.note;
  static const Field<StayBookingModel, String> _f$note = Field(
    'note',
    _$note,
    opt: true,
  );
  static DateTime? _$createdAt(StayBookingModel v) => v.createdAt;
  static const Field<StayBookingModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );
  static DateTime? _$updatedAt(StayBookingModel v) => v.updatedAt;
  static const Field<StayBookingModel, DateTime> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
  );

  @override
  final MappableFields<StayBookingModel> fields = const {
    #id: _f$id,
    #businessId: _f$businessId,
    #userId: _f$userId,
    #checkIn: _f$checkIn,
    #checkOut: _f$checkOut,
    #adults: _f$adults,
    #children: _f$children,
    #unitId: _f$unitId,
    #totalPrice: _f$totalPrice,
    #currency: _f$currency,
    #status: _f$status,
    #note: _f$note,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static StayBookingModel _instantiate(DecodingData data) {
    return StayBookingModel(
      id: data.dec(_f$id),
      businessId: data.dec(_f$businessId),
      userId: data.dec(_f$userId),
      checkIn: data.dec(_f$checkIn),
      checkOut: data.dec(_f$checkOut),
      adults: data.dec(_f$adults),
      children: data.dec(_f$children),
      unitId: data.dec(_f$unitId),
      totalPrice: data.dec(_f$totalPrice),
      currency: data.dec(_f$currency),
      status: data.dec(_f$status),
      note: data.dec(_f$note),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static StayBookingModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StayBookingModel>(map);
  }

  static StayBookingModel fromJson(String json) {
    return ensureInitialized().decodeJson<StayBookingModel>(json);
  }
}

mixin StayBookingModelMappable {
  String toJson() {
    return StayBookingModelMapper.ensureInitialized()
        .encodeJson<StayBookingModel>(this as StayBookingModel);
  }

  Map<String, dynamic> toMap() {
    return StayBookingModelMapper.ensureInitialized()
        .encodeMap<StayBookingModel>(this as StayBookingModel);
  }

  StayBookingModelCopyWith<StayBookingModel, StayBookingModel, StayBookingModel>
  get copyWith =>
      _StayBookingModelCopyWithImpl<StayBookingModel, StayBookingModel>(
        this as StayBookingModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return StayBookingModelMapper.ensureInitialized().stringifyValue(
      this as StayBookingModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return StayBookingModelMapper.ensureInitialized().equalsValue(
      this as StayBookingModel,
      other,
    );
  }

  @override
  int get hashCode {
    return StayBookingModelMapper.ensureInitialized().hashValue(
      this as StayBookingModel,
    );
  }
}

extension StayBookingModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StayBookingModel, $Out> {
  StayBookingModelCopyWith<$R, StayBookingModel, $Out>
  get $asStayBookingModel =>
      $base.as((v, t, t2) => _StayBookingModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class StayBookingModelCopyWith<$R, $In extends StayBookingModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? businessId,
    String? userId,
    DateTime? checkIn,
    DateTime? checkOut,
    int? adults,
    int? children,
    String? unitId,
    double? totalPrice,
    String? currency,
    StayBookingStatus? status,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  StayBookingModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _StayBookingModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StayBookingModel, $Out>
    implements StayBookingModelCopyWith<$R, StayBookingModel, $Out> {
  _StayBookingModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StayBookingModel> $mapper =
      StayBookingModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? businessId,
    String? userId,
    DateTime? checkIn,
    DateTime? checkOut,
    int? adults,
    int? children,
    Object? unitId = $none,
    double? totalPrice,
    String? currency,
    StayBookingStatus? status,
    Object? note = $none,
    Object? createdAt = $none,
    Object? updatedAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (businessId != null) #businessId: businessId,
      if (userId != null) #userId: userId,
      if (checkIn != null) #checkIn: checkIn,
      if (checkOut != null) #checkOut: checkOut,
      if (adults != null) #adults: adults,
      if (children != null) #children: children,
      if (unitId != $none) #unitId: unitId,
      if (totalPrice != null) #totalPrice: totalPrice,
      if (currency != null) #currency: currency,
      if (status != null) #status: status,
      if (note != $none) #note: note,
      if (createdAt != $none) #createdAt: createdAt,
      if (updatedAt != $none) #updatedAt: updatedAt,
    }),
  );
  @override
  StayBookingModel $make(CopyWithData data) => StayBookingModel(
    id: data.get(#id, or: $value.id),
    businessId: data.get(#businessId, or: $value.businessId),
    userId: data.get(#userId, or: $value.userId),
    checkIn: data.get(#checkIn, or: $value.checkIn),
    checkOut: data.get(#checkOut, or: $value.checkOut),
    adults: data.get(#adults, or: $value.adults),
    children: data.get(#children, or: $value.children),
    unitId: data.get(#unitId, or: $value.unitId),
    totalPrice: data.get(#totalPrice, or: $value.totalPrice),
    currency: data.get(#currency, or: $value.currency),
    status: data.get(#status, or: $value.status),
    note: data.get(#note, or: $value.note),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
  );

  @override
  StayBookingModelCopyWith<$R2, StayBookingModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _StayBookingModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

