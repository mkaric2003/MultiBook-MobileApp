// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'service_provider_model.dart';

class ServiceProviderModelMapper extends ClassMapperBase<ServiceProviderModel> {
  ServiceProviderModelMapper._();

  static ServiceProviderModelMapper? _instance;
  static ServiceProviderModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ServiceProviderModelMapper._());
      ServiceAvailabilitySlotModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ServiceProviderModel';

  static String _$id(ServiceProviderModel v) => v.id;
  static const Field<ServiceProviderModel, String> _f$id = Field('id', _$id);
  static String _$name(ServiceProviderModel v) => v.name;
  static const Field<ServiceProviderModel, String> _f$name = Field(
    'name',
    _$name,
  );
  static String? _$title(ServiceProviderModel v) => v.title;
  static const Field<ServiceProviderModel, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
  );
  static double _$commissionRate(ServiceProviderModel v) => v.commissionRate;
  static const Field<ServiceProviderModel, double> _f$commissionRate = Field(
    'commissionRate',
    _$commissionRate,
    opt: true,
    def: 100,
  );
  static List<ServiceAvailabilitySlotModel> _$availabilitySlots(
    ServiceProviderModel v,
  ) => v.availabilitySlots;
  static const Field<ServiceProviderModel, List<ServiceAvailabilitySlotModel>>
  _f$availabilitySlots = Field(
    'availabilitySlots',
    _$availabilitySlots,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<ServiceProviderModel> fields = const {
    #id: _f$id,
    #name: _f$name,
    #title: _f$title,
    #commissionRate: _f$commissionRate,
    #availabilitySlots: _f$availabilitySlots,
  };

  static ServiceProviderModel _instantiate(DecodingData data) {
    return ServiceProviderModel(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      title: data.dec(_f$title),
      commissionRate: data.dec(_f$commissionRate),
      availabilitySlots: data.dec(_f$availabilitySlots),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ServiceProviderModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ServiceProviderModel>(map);
  }

  static ServiceProviderModel fromJson(String json) {
    return ensureInitialized().decodeJson<ServiceProviderModel>(json);
  }
}

mixin ServiceProviderModelMappable {
  String toJson() {
    return ServiceProviderModelMapper.ensureInitialized()
        .encodeJson<ServiceProviderModel>(this as ServiceProviderModel);
  }

  Map<String, dynamic> toMap() {
    return ServiceProviderModelMapper.ensureInitialized()
        .encodeMap<ServiceProviderModel>(this as ServiceProviderModel);
  }

  ServiceProviderModelCopyWith<
    ServiceProviderModel,
    ServiceProviderModel,
    ServiceProviderModel
  >
  get copyWith =>
      _ServiceProviderModelCopyWithImpl<
        ServiceProviderModel,
        ServiceProviderModel
      >(this as ServiceProviderModel, $identity, $identity);
  @override
  String toString() {
    return ServiceProviderModelMapper.ensureInitialized().stringifyValue(
      this as ServiceProviderModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ServiceProviderModelMapper.ensureInitialized().equalsValue(
      this as ServiceProviderModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ServiceProviderModelMapper.ensureInitialized().hashValue(
      this as ServiceProviderModel,
    );
  }
}

extension ServiceProviderModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ServiceProviderModel, $Out> {
  ServiceProviderModelCopyWith<$R, ServiceProviderModel, $Out>
  get $asServiceProviderModel => $base.as(
    (v, t, t2) => _ServiceProviderModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ServiceProviderModelCopyWith<
  $R,
  $In extends ServiceProviderModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    ServiceAvailabilitySlotModel,
    ServiceAvailabilitySlotModelCopyWith<
      $R,
      ServiceAvailabilitySlotModel,
      ServiceAvailabilitySlotModel
    >
  >
  get availabilitySlots;
  $R call({
    String? id,
    String? name,
    String? title,
    double? commissionRate,
    List<ServiceAvailabilitySlotModel>? availabilitySlots,
  });
  ServiceProviderModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ServiceProviderModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ServiceProviderModel, $Out>
    implements ServiceProviderModelCopyWith<$R, ServiceProviderModel, $Out> {
  _ServiceProviderModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ServiceProviderModel> $mapper =
      ServiceProviderModelMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    ServiceAvailabilitySlotModel,
    ServiceAvailabilitySlotModelCopyWith<
      $R,
      ServiceAvailabilitySlotModel,
      ServiceAvailabilitySlotModel
    >
  >
  get availabilitySlots => ListCopyWith(
    $value.availabilitySlots,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(availabilitySlots: v),
  );
  @override
  $R call({
    String? id,
    String? name,
    Object? title = $none,
    double? commissionRate,
    List<ServiceAvailabilitySlotModel>? availabilitySlots,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (title != $none) #title: title,
      if (commissionRate != null) #commissionRate: commissionRate,
      if (availabilitySlots != null) #availabilitySlots: availabilitySlots,
    }),
  );
  @override
  ServiceProviderModel $make(CopyWithData data) => ServiceProviderModel(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    title: data.get(#title, or: $value.title),
    commissionRate: data.get(#commissionRate, or: $value.commissionRate),
    availabilitySlots: data.get(
      #availabilitySlots,
      or: $value.availabilitySlots,
    ),
  );

  @override
  ServiceProviderModelCopyWith<$R2, ServiceProviderModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ServiceProviderModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

