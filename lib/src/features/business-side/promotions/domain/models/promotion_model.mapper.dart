// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'promotion_model.dart';

class PromotionModelMapper extends ClassMapperBase<PromotionModel> {
  PromotionModelMapper._();

  static PromotionModelMapper? _instance;
  static PromotionModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PromotionModelMapper._());
      PromotionTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PromotionModel';

  static String _$id(PromotionModel v) => v.id;
  static const Field<PromotionModel, String> _f$id = Field('id', _$id);
  static String _$businessId(PromotionModel v) => v.businessId;
  static const Field<PromotionModel, String> _f$businessId = Field(
    'businessId',
    _$businessId,
  );
  static String _$ownerId(PromotionModel v) => v.ownerId;
  static const Field<PromotionModel, String> _f$ownerId = Field(
    'ownerId',
    _$ownerId,
  );
  static String _$name(PromotionModel v) => v.name;
  static const Field<PromotionModel, String> _f$name = Field('name', _$name);
  static PromotionType _$type(PromotionModel v) => v.type;
  static const Field<PromotionModel, PromotionType> _f$type = Field(
    'type',
    _$type,
  );
  static int _$value(PromotionModel v) => v.value;
  static const Field<PromotionModel, int> _f$value = Field('value', _$value);
  static DateTime _$startsAt(PromotionModel v) => v.startsAt;
  static const Field<PromotionModel, DateTime> _f$startsAt = Field(
    'startsAt',
    _$startsAt,
  );
  static DateTime _$endsAt(PromotionModel v) => v.endsAt;
  static const Field<PromotionModel, DateTime> _f$endsAt = Field(
    'endsAt',
    _$endsAt,
  );
  static bool _$isActive(PromotionModel v) => v.isActive;
  static const Field<PromotionModel, bool> _f$isActive = Field(
    'isActive',
    _$isActive,
  );
  static String? _$code(PromotionModel v) => v.code;
  static const Field<PromotionModel, String> _f$code = Field(
    'code',
    _$code,
    opt: true,
  );
  static int _$minimumAmount(PromotionModel v) => v.minimumAmount;
  static const Field<PromotionModel, int> _f$minimumAmount = Field(
    'minimumAmount',
    _$minimumAmount,
    opt: true,
    def: 0,
  );
  static int _$minimumNights(PromotionModel v) => v.minimumNights;
  static const Field<PromotionModel, int> _f$minimumNights = Field(
    'minimumNights',
    _$minimumNights,
    opt: true,
    def: 1,
  );
  static int? _$usageLimit(PromotionModel v) => v.usageLimit;
  static const Field<PromotionModel, int> _f$usageLimit = Field(
    'usageLimit',
    _$usageLimit,
    opt: true,
  );
  static int _$usageCount(PromotionModel v) => v.usageCount;
  static const Field<PromotionModel, int> _f$usageCount = Field(
    'usageCount',
    _$usageCount,
    opt: true,
    def: 0,
  );
  static DateTime? _$createdAt(PromotionModel v) => v.createdAt;
  static const Field<PromotionModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );

  @override
  final MappableFields<PromotionModel> fields = const {
    #id: _f$id,
    #businessId: _f$businessId,
    #ownerId: _f$ownerId,
    #name: _f$name,
    #type: _f$type,
    #value: _f$value,
    #startsAt: _f$startsAt,
    #endsAt: _f$endsAt,
    #isActive: _f$isActive,
    #code: _f$code,
    #minimumAmount: _f$minimumAmount,
    #minimumNights: _f$minimumNights,
    #usageLimit: _f$usageLimit,
    #usageCount: _f$usageCount,
    #createdAt: _f$createdAt,
  };

  static PromotionModel _instantiate(DecodingData data) {
    return PromotionModel(
      id: data.dec(_f$id),
      businessId: data.dec(_f$businessId),
      ownerId: data.dec(_f$ownerId),
      name: data.dec(_f$name),
      type: data.dec(_f$type),
      value: data.dec(_f$value),
      startsAt: data.dec(_f$startsAt),
      endsAt: data.dec(_f$endsAt),
      isActive: data.dec(_f$isActive),
      code: data.dec(_f$code),
      minimumAmount: data.dec(_f$minimumAmount),
      minimumNights: data.dec(_f$minimumNights),
      usageLimit: data.dec(_f$usageLimit),
      usageCount: data.dec(_f$usageCount),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PromotionModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PromotionModel>(map);
  }

  static PromotionModel fromJson(String json) {
    return ensureInitialized().decodeJson<PromotionModel>(json);
  }
}

mixin PromotionModelMappable {
  String toJson() {
    return PromotionModelMapper.ensureInitialized().encodeJson<PromotionModel>(
      this as PromotionModel,
    );
  }

  Map<String, dynamic> toMap() {
    return PromotionModelMapper.ensureInitialized().encodeMap<PromotionModel>(
      this as PromotionModel,
    );
  }

  PromotionModelCopyWith<PromotionModel, PromotionModel, PromotionModel>
  get copyWith => _PromotionModelCopyWithImpl<PromotionModel, PromotionModel>(
    this as PromotionModel,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return PromotionModelMapper.ensureInitialized().stringifyValue(
      this as PromotionModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return PromotionModelMapper.ensureInitialized().equalsValue(
      this as PromotionModel,
      other,
    );
  }

  @override
  int get hashCode {
    return PromotionModelMapper.ensureInitialized().hashValue(
      this as PromotionModel,
    );
  }
}

extension PromotionModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PromotionModel, $Out> {
  PromotionModelCopyWith<$R, PromotionModel, $Out> get $asPromotionModel =>
      $base.as((v, t, t2) => _PromotionModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PromotionModelCopyWith<$R, $In extends PromotionModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? businessId,
    String? ownerId,
    String? name,
    PromotionType? type,
    int? value,
    DateTime? startsAt,
    DateTime? endsAt,
    bool? isActive,
    String? code,
    int? minimumAmount,
    int? minimumNights,
    int? usageLimit,
    int? usageCount,
    DateTime? createdAt,
  });
  PromotionModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PromotionModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PromotionModel, $Out>
    implements PromotionModelCopyWith<$R, PromotionModel, $Out> {
  _PromotionModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PromotionModel> $mapper =
      PromotionModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? businessId,
    String? ownerId,
    String? name,
    PromotionType? type,
    int? value,
    DateTime? startsAt,
    DateTime? endsAt,
    bool? isActive,
    Object? code = $none,
    int? minimumAmount,
    int? minimumNights,
    Object? usageLimit = $none,
    int? usageCount,
    Object? createdAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (businessId != null) #businessId: businessId,
      if (ownerId != null) #ownerId: ownerId,
      if (name != null) #name: name,
      if (type != null) #type: type,
      if (value != null) #value: value,
      if (startsAt != null) #startsAt: startsAt,
      if (endsAt != null) #endsAt: endsAt,
      if (isActive != null) #isActive: isActive,
      if (code != $none) #code: code,
      if (minimumAmount != null) #minimumAmount: minimumAmount,
      if (minimumNights != null) #minimumNights: minimumNights,
      if (usageLimit != $none) #usageLimit: usageLimit,
      if (usageCount != null) #usageCount: usageCount,
      if (createdAt != $none) #createdAt: createdAt,
    }),
  );
  @override
  PromotionModel $make(CopyWithData data) => PromotionModel(
    id: data.get(#id, or: $value.id),
    businessId: data.get(#businessId, or: $value.businessId),
    ownerId: data.get(#ownerId, or: $value.ownerId),
    name: data.get(#name, or: $value.name),
    type: data.get(#type, or: $value.type),
    value: data.get(#value, or: $value.value),
    startsAt: data.get(#startsAt, or: $value.startsAt),
    endsAt: data.get(#endsAt, or: $value.endsAt),
    isActive: data.get(#isActive, or: $value.isActive),
    code: data.get(#code, or: $value.code),
    minimumAmount: data.get(#minimumAmount, or: $value.minimumAmount),
    minimumNights: data.get(#minimumNights, or: $value.minimumNights),
    usageLimit: data.get(#usageLimit, or: $value.usageLimit),
    usageCount: data.get(#usageCount, or: $value.usageCount),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  PromotionModelCopyWith<$R2, PromotionModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PromotionModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

