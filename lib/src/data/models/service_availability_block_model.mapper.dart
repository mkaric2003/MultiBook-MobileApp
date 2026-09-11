// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'service_availability_block_model.dart';

class ServiceAvailabilityBlockModelMapper
    extends ClassMapperBase<ServiceAvailabilityBlockModel> {
  ServiceAvailabilityBlockModelMapper._();

  static ServiceAvailabilityBlockModelMapper? _instance;
  static ServiceAvailabilityBlockModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = ServiceAvailabilityBlockModelMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'ServiceAvailabilityBlockModel';

  static String _$id(ServiceAvailabilityBlockModel v) => v.id;
  static const Field<ServiceAvailabilityBlockModel, String> _f$id = Field(
    'id',
    _$id,
  );
  static String _$staffId(ServiceAvailabilityBlockModel v) => v.staffId;
  static const Field<ServiceAvailabilityBlockModel, String> _f$staffId = Field(
    'staffId',
    _$staffId,
    key: r'staff_id',
  );
  static DateTime _$startAt(ServiceAvailabilityBlockModel v) => v.startAt;
  static const Field<ServiceAvailabilityBlockModel, DateTime> _f$startAt =
      Field('startAt', _$startAt, key: r'start_at');
  static DateTime _$endAt(ServiceAvailabilityBlockModel v) => v.endAt;
  static const Field<ServiceAvailabilityBlockModel, DateTime> _f$endAt = Field(
    'endAt',
    _$endAt,
    key: r'end_at',
  );
  static DateTime _$createdAt(ServiceAvailabilityBlockModel v) => v.createdAt;
  static const Field<ServiceAvailabilityBlockModel, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, key: r'created_at');
  static String? _$reason(ServiceAvailabilityBlockModel v) => v.reason;
  static const Field<ServiceAvailabilityBlockModel, String> _f$reason = Field(
    'reason',
    _$reason,
    opt: true,
  );

  @override
  final MappableFields<ServiceAvailabilityBlockModel> fields = const {
    #id: _f$id,
    #staffId: _f$staffId,
    #startAt: _f$startAt,
    #endAt: _f$endAt,
    #createdAt: _f$createdAt,
    #reason: _f$reason,
  };

  static ServiceAvailabilityBlockModel _instantiate(DecodingData data) {
    return ServiceAvailabilityBlockModel(
      id: data.dec(_f$id),
      staffId: data.dec(_f$staffId),
      startAt: data.dec(_f$startAt),
      endAt: data.dec(_f$endAt),
      createdAt: data.dec(_f$createdAt),
      reason: data.dec(_f$reason),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ServiceAvailabilityBlockModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ServiceAvailabilityBlockModel>(map);
  }

  static ServiceAvailabilityBlockModel fromJson(String json) {
    return ensureInitialized().decodeJson<ServiceAvailabilityBlockModel>(json);
  }
}

mixin ServiceAvailabilityBlockModelMappable {
  String toJson() {
    return ServiceAvailabilityBlockModelMapper.ensureInitialized()
        .encodeJson<ServiceAvailabilityBlockModel>(
          this as ServiceAvailabilityBlockModel,
        );
  }

  Map<String, dynamic> toMap() {
    return ServiceAvailabilityBlockModelMapper.ensureInitialized()
        .encodeMap<ServiceAvailabilityBlockModel>(
          this as ServiceAvailabilityBlockModel,
        );
  }

  ServiceAvailabilityBlockModelCopyWith<
    ServiceAvailabilityBlockModel,
    ServiceAvailabilityBlockModel,
    ServiceAvailabilityBlockModel
  >
  get copyWith =>
      _ServiceAvailabilityBlockModelCopyWithImpl<
        ServiceAvailabilityBlockModel,
        ServiceAvailabilityBlockModel
      >(this as ServiceAvailabilityBlockModel, $identity, $identity);
  @override
  String toString() {
    return ServiceAvailabilityBlockModelMapper.ensureInitialized()
        .stringifyValue(this as ServiceAvailabilityBlockModel);
  }

  @override
  bool operator ==(Object other) {
    return ServiceAvailabilityBlockModelMapper.ensureInitialized().equalsValue(
      this as ServiceAvailabilityBlockModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ServiceAvailabilityBlockModelMapper.ensureInitialized().hashValue(
      this as ServiceAvailabilityBlockModel,
    );
  }
}

extension ServiceAvailabilityBlockModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ServiceAvailabilityBlockModel, $Out> {
  ServiceAvailabilityBlockModelCopyWith<$R, ServiceAvailabilityBlockModel, $Out>
  get $asServiceAvailabilityBlockModel => $base.as(
    (v, t, t2) =>
        _ServiceAvailabilityBlockModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ServiceAvailabilityBlockModelCopyWith<
  $R,
  $In extends ServiceAvailabilityBlockModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? staffId,
    DateTime? startAt,
    DateTime? endAt,
    DateTime? createdAt,
    String? reason,
  });
  ServiceAvailabilityBlockModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ServiceAvailabilityBlockModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ServiceAvailabilityBlockModel, $Out>
    implements
        ServiceAvailabilityBlockModelCopyWith<
          $R,
          ServiceAvailabilityBlockModel,
          $Out
        > {
  _ServiceAvailabilityBlockModelCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<ServiceAvailabilityBlockModel> $mapper =
      ServiceAvailabilityBlockModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? staffId,
    DateTime? startAt,
    DateTime? endAt,
    DateTime? createdAt,
    Object? reason = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (staffId != null) #staffId: staffId,
      if (startAt != null) #startAt: startAt,
      if (endAt != null) #endAt: endAt,
      if (createdAt != null) #createdAt: createdAt,
      if (reason != $none) #reason: reason,
    }),
  );
  @override
  ServiceAvailabilityBlockModel $make(CopyWithData data) =>
      ServiceAvailabilityBlockModel(
        id: data.get(#id, or: $value.id),
        staffId: data.get(#staffId, or: $value.staffId),
        startAt: data.get(#startAt, or: $value.startAt),
        endAt: data.get(#endAt, or: $value.endAt),
        createdAt: data.get(#createdAt, or: $value.createdAt),
        reason: data.get(#reason, or: $value.reason),
      );

  @override
  ServiceAvailabilityBlockModelCopyWith<
    $R2,
    ServiceAvailabilityBlockModel,
    $Out2
  >
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ServiceAvailabilityBlockModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

