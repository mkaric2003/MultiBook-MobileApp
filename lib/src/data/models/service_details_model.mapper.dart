// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'service_details_model.dart';

class ServiceDetailsModelMapper extends ClassMapperBase<ServiceDetailsModel> {
  ServiceDetailsModelMapper._();

  static ServiceDetailsModelMapper? _instance;
  static ServiceDetailsModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ServiceDetailsModelMapper._());
      ServiceOfferingModelMapper.ensureInitialized();
      ServiceAvailabilitySlotModelMapper.ensureInitialized();
      ServiceProviderModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ServiceDetailsModel';

  static List<ServiceOfferingModel> _$offerings(ServiceDetailsModel v) =>
      v.offerings;
  static const Field<ServiceDetailsModel, List<ServiceOfferingModel>>
  _f$offerings = Field('offerings', _$offerings, opt: true, def: const []);
  static List<ServiceAvailabilitySlotModel> _$availabilitySlots(
    ServiceDetailsModel v,
  ) => v.availabilitySlots;
  static const Field<ServiceDetailsModel, List<ServiceAvailabilitySlotModel>>
  _f$availabilitySlots = Field(
    'availabilitySlots',
    _$availabilitySlots,
    opt: true,
    def: const [],
  );
  static ServiceProviderModel? _$provider(ServiceDetailsModel v) => v.provider;
  static const Field<ServiceDetailsModel, ServiceProviderModel> _f$provider =
      Field('provider', _$provider, opt: true);

  @override
  final MappableFields<ServiceDetailsModel> fields = const {
    #offerings: _f$offerings,
    #availabilitySlots: _f$availabilitySlots,
    #provider: _f$provider,
  };

  static ServiceDetailsModel _instantiate(DecodingData data) {
    return ServiceDetailsModel(
      offerings: data.dec(_f$offerings),
      availabilitySlots: data.dec(_f$availabilitySlots),
      provider: data.dec(_f$provider),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ServiceDetailsModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ServiceDetailsModel>(map);
  }

  static ServiceDetailsModel fromJson(String json) {
    return ensureInitialized().decodeJson<ServiceDetailsModel>(json);
  }
}

mixin ServiceDetailsModelMappable {
  String toJson() {
    return ServiceDetailsModelMapper.ensureInitialized()
        .encodeJson<ServiceDetailsModel>(this as ServiceDetailsModel);
  }

  Map<String, dynamic> toMap() {
    return ServiceDetailsModelMapper.ensureInitialized()
        .encodeMap<ServiceDetailsModel>(this as ServiceDetailsModel);
  }

  ServiceDetailsModelCopyWith<
    ServiceDetailsModel,
    ServiceDetailsModel,
    ServiceDetailsModel
  >
  get copyWith =>
      _ServiceDetailsModelCopyWithImpl<
        ServiceDetailsModel,
        ServiceDetailsModel
      >(this as ServiceDetailsModel, $identity, $identity);
  @override
  String toString() {
    return ServiceDetailsModelMapper.ensureInitialized().stringifyValue(
      this as ServiceDetailsModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ServiceDetailsModelMapper.ensureInitialized().equalsValue(
      this as ServiceDetailsModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ServiceDetailsModelMapper.ensureInitialized().hashValue(
      this as ServiceDetailsModel,
    );
  }
}

extension ServiceDetailsModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ServiceDetailsModel, $Out> {
  ServiceDetailsModelCopyWith<$R, ServiceDetailsModel, $Out>
  get $asServiceDetailsModel => $base.as(
    (v, t, t2) => _ServiceDetailsModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ServiceDetailsModelCopyWith<
  $R,
  $In extends ServiceDetailsModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    ServiceOfferingModel,
    ServiceOfferingModelCopyWith<$R, ServiceOfferingModel, ServiceOfferingModel>
  >
  get offerings;
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
  ServiceProviderModelCopyWith<$R, ServiceProviderModel, ServiceProviderModel>?
  get provider;
  $R call({
    List<ServiceOfferingModel>? offerings,
    List<ServiceAvailabilitySlotModel>? availabilitySlots,
    ServiceProviderModel? provider,
  });
  ServiceDetailsModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ServiceDetailsModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ServiceDetailsModel, $Out>
    implements ServiceDetailsModelCopyWith<$R, ServiceDetailsModel, $Out> {
  _ServiceDetailsModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ServiceDetailsModel> $mapper =
      ServiceDetailsModelMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    ServiceOfferingModel,
    ServiceOfferingModelCopyWith<$R, ServiceOfferingModel, ServiceOfferingModel>
  >
  get offerings => ListCopyWith(
    $value.offerings,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(offerings: v),
  );
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
  ServiceProviderModelCopyWith<$R, ServiceProviderModel, ServiceProviderModel>?
  get provider => $value.provider?.copyWith.$chain((v) => call(provider: v));
  @override
  $R call({
    List<ServiceOfferingModel>? offerings,
    List<ServiceAvailabilitySlotModel>? availabilitySlots,
    Object? provider = $none,
  }) => $apply(
    FieldCopyWithData({
      if (offerings != null) #offerings: offerings,
      if (availabilitySlots != null) #availabilitySlots: availabilitySlots,
      if (provider != $none) #provider: provider,
    }),
  );
  @override
  ServiceDetailsModel $make(CopyWithData data) => ServiceDetailsModel(
    offerings: data.get(#offerings, or: $value.offerings),
    availabilitySlots: data.get(
      #availabilitySlots,
      or: $value.availabilitySlots,
    ),
    provider: data.get(#provider, or: $value.provider),
  );

  @override
  ServiceDetailsModelCopyWith<$R2, ServiceDetailsModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ServiceDetailsModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

