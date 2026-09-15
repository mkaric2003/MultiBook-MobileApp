// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'service_availability_slot_model.dart';

class ServiceAvailabilitySlotModelMapper
    extends ClassMapperBase<ServiceAvailabilitySlotModel> {
  ServiceAvailabilitySlotModelMapper._();

  static ServiceAvailabilitySlotModelMapper? _instance;
  static ServiceAvailabilitySlotModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = ServiceAvailabilitySlotModelMapper._(),
      );
      ServiceWeekdayMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ServiceAvailabilitySlotModel';

  static String _$id(ServiceAvailabilitySlotModel v) => v.id;
  static const Field<ServiceAvailabilitySlotModel, String> _f$id = Field(
    'id',
    _$id,
  );
  static ServiceWeekday _$weekday(ServiceAvailabilitySlotModel v) => v.weekday;
  static const Field<ServiceAvailabilitySlotModel, ServiceWeekday> _f$weekday =
      Field('weekday', _$weekday);
  static int _$startMinutes(ServiceAvailabilitySlotModel v) => v.startMinutes;
  static const Field<ServiceAvailabilitySlotModel, int> _f$startMinutes = Field(
    'startMinutes',
    _$startMinutes,
  );
  static int _$endMinutes(ServiceAvailabilitySlotModel v) => v.endMinutes;
  static const Field<ServiceAvailabilitySlotModel, int> _f$endMinutes = Field(
    'endMinutes',
    _$endMinutes,
  );

  @override
  final MappableFields<ServiceAvailabilitySlotModel> fields = const {
    #id: _f$id,
    #weekday: _f$weekday,
    #startMinutes: _f$startMinutes,
    #endMinutes: _f$endMinutes,
  };

  static ServiceAvailabilitySlotModel _instantiate(DecodingData data) {
    return ServiceAvailabilitySlotModel(
      id: data.dec(_f$id),
      weekday: data.dec(_f$weekday),
      startMinutes: data.dec(_f$startMinutes),
      endMinutes: data.dec(_f$endMinutes),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ServiceAvailabilitySlotModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ServiceAvailabilitySlotModel>(map);
  }

  static ServiceAvailabilitySlotModel fromJson(String json) {
    return ensureInitialized().decodeJson<ServiceAvailabilitySlotModel>(json);
  }
}

mixin ServiceAvailabilitySlotModelMappable {
  String toJson() {
    return ServiceAvailabilitySlotModelMapper.ensureInitialized()
        .encodeJson<ServiceAvailabilitySlotModel>(
          this as ServiceAvailabilitySlotModel,
        );
  }

  Map<String, dynamic> toMap() {
    return ServiceAvailabilitySlotModelMapper.ensureInitialized()
        .encodeMap<ServiceAvailabilitySlotModel>(
          this as ServiceAvailabilitySlotModel,
        );
  }

  ServiceAvailabilitySlotModelCopyWith<
    ServiceAvailabilitySlotModel,
    ServiceAvailabilitySlotModel,
    ServiceAvailabilitySlotModel
  >
  get copyWith =>
      _ServiceAvailabilitySlotModelCopyWithImpl<
        ServiceAvailabilitySlotModel,
        ServiceAvailabilitySlotModel
      >(this as ServiceAvailabilitySlotModel, $identity, $identity);
  @override
  String toString() {
    return ServiceAvailabilitySlotModelMapper.ensureInitialized()
        .stringifyValue(this as ServiceAvailabilitySlotModel);
  }

  @override
  bool operator ==(Object other) {
    return ServiceAvailabilitySlotModelMapper.ensureInitialized().equalsValue(
      this as ServiceAvailabilitySlotModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ServiceAvailabilitySlotModelMapper.ensureInitialized().hashValue(
      this as ServiceAvailabilitySlotModel,
    );
  }
}

extension ServiceAvailabilitySlotModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ServiceAvailabilitySlotModel, $Out> {
  ServiceAvailabilitySlotModelCopyWith<$R, ServiceAvailabilitySlotModel, $Out>
  get $asServiceAvailabilitySlotModel => $base.as(
    (v, t, t2) => _ServiceAvailabilitySlotModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ServiceAvailabilitySlotModelCopyWith<
  $R,
  $In extends ServiceAvailabilitySlotModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    ServiceWeekday? weekday,
    int? startMinutes,
    int? endMinutes,
  });
  ServiceAvailabilitySlotModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ServiceAvailabilitySlotModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ServiceAvailabilitySlotModel, $Out>
    implements
        ServiceAvailabilitySlotModelCopyWith<
          $R,
          ServiceAvailabilitySlotModel,
          $Out
        > {
  _ServiceAvailabilitySlotModelCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<ServiceAvailabilitySlotModel> $mapper =
      ServiceAvailabilitySlotModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    ServiceWeekday? weekday,
    int? startMinutes,
    int? endMinutes,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (weekday != null) #weekday: weekday,
      if (startMinutes != null) #startMinutes: startMinutes,
      if (endMinutes != null) #endMinutes: endMinutes,
    }),
  );
  @override
  ServiceAvailabilitySlotModel $make(CopyWithData data) =>
      ServiceAvailabilitySlotModel(
        id: data.get(#id, or: $value.id),
        weekday: data.get(#weekday, or: $value.weekday),
        startMinutes: data.get(#startMinutes, or: $value.startMinutes),
        endMinutes: data.get(#endMinutes, or: $value.endMinutes),
      );

  @override
  ServiceAvailabilitySlotModelCopyWith<$R2, ServiceAvailabilitySlotModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ServiceAvailabilitySlotModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

