// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'service_offering_model.dart';

class ServiceOfferingModelMapper extends ClassMapperBase<ServiceOfferingModel> {
  ServiceOfferingModelMapper._();

  static ServiceOfferingModelMapper? _instance;
  static ServiceOfferingModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ServiceOfferingModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ServiceOfferingModel';

  static String _$id(ServiceOfferingModel v) => v.id;
  static const Field<ServiceOfferingModel, String> _f$id = Field('id', _$id);
  static String _$name(ServiceOfferingModel v) => v.name;
  static const Field<ServiceOfferingModel, String> _f$name = Field(
    'name',
    _$name,
  );
  static int _$durationMinutes(ServiceOfferingModel v) => v.durationMinutes;
  static const Field<ServiceOfferingModel, int> _f$durationMinutes = Field(
    'durationMinutes',
    _$durationMinutes,
  );
  static int _$price(ServiceOfferingModel v) => v.price;
  static const Field<ServiceOfferingModel, int> _f$price = Field(
    'price',
    _$price,
  );
  static String? _$description(ServiceOfferingModel v) => v.description;
  static const Field<ServiceOfferingModel, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
  );
  static bool _$isActive(ServiceOfferingModel v) => v.isActive;
  static const Field<ServiceOfferingModel, bool> _f$isActive = Field(
    'isActive',
    _$isActive,
    opt: true,
    def: true,
  );

  @override
  final MappableFields<ServiceOfferingModel> fields = const {
    #id: _f$id,
    #name: _f$name,
    #durationMinutes: _f$durationMinutes,
    #price: _f$price,
    #description: _f$description,
    #isActive: _f$isActive,
  };

  static ServiceOfferingModel _instantiate(DecodingData data) {
    return ServiceOfferingModel(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      durationMinutes: data.dec(_f$durationMinutes),
      price: data.dec(_f$price),
      description: data.dec(_f$description),
      isActive: data.dec(_f$isActive),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ServiceOfferingModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ServiceOfferingModel>(map);
  }

  static ServiceOfferingModel fromJson(String json) {
    return ensureInitialized().decodeJson<ServiceOfferingModel>(json);
  }
}

mixin ServiceOfferingModelMappable {
  String toJson() {
    return ServiceOfferingModelMapper.ensureInitialized()
        .encodeJson<ServiceOfferingModel>(this as ServiceOfferingModel);
  }

  Map<String, dynamic> toMap() {
    return ServiceOfferingModelMapper.ensureInitialized()
        .encodeMap<ServiceOfferingModel>(this as ServiceOfferingModel);
  }

  ServiceOfferingModelCopyWith<
    ServiceOfferingModel,
    ServiceOfferingModel,
    ServiceOfferingModel
  >
  get copyWith =>
      _ServiceOfferingModelCopyWithImpl<
        ServiceOfferingModel,
        ServiceOfferingModel
      >(this as ServiceOfferingModel, $identity, $identity);
  @override
  String toString() {
    return ServiceOfferingModelMapper.ensureInitialized().stringifyValue(
      this as ServiceOfferingModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ServiceOfferingModelMapper.ensureInitialized().equalsValue(
      this as ServiceOfferingModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ServiceOfferingModelMapper.ensureInitialized().hashValue(
      this as ServiceOfferingModel,
    );
  }
}

extension ServiceOfferingModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ServiceOfferingModel, $Out> {
  ServiceOfferingModelCopyWith<$R, ServiceOfferingModel, $Out>
  get $asServiceOfferingModel => $base.as(
    (v, t, t2) => _ServiceOfferingModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ServiceOfferingModelCopyWith<
  $R,
  $In extends ServiceOfferingModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? name,
    int? durationMinutes,
    int? price,
    String? description,
    bool? isActive,
  });
  ServiceOfferingModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ServiceOfferingModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ServiceOfferingModel, $Out>
    implements ServiceOfferingModelCopyWith<$R, ServiceOfferingModel, $Out> {
  _ServiceOfferingModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ServiceOfferingModel> $mapper =
      ServiceOfferingModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? name,
    int? durationMinutes,
    int? price,
    Object? description = $none,
    bool? isActive,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (durationMinutes != null) #durationMinutes: durationMinutes,
      if (price != null) #price: price,
      if (description != $none) #description: description,
      if (isActive != null) #isActive: isActive,
    }),
  );
  @override
  ServiceOfferingModel $make(CopyWithData data) => ServiceOfferingModel(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    durationMinutes: data.get(#durationMinutes, or: $value.durationMinutes),
    price: data.get(#price, or: $value.price),
    description: data.get(#description, or: $value.description),
    isActive: data.get(#isActive, or: $value.isActive),
  );

  @override
  ServiceOfferingModelCopyWith<$R2, ServiceOfferingModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ServiceOfferingModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

