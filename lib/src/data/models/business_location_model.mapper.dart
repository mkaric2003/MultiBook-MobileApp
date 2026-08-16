// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'business_location_model.dart';

class BusinessLocationModelMapper
    extends ClassMapperBase<BusinessLocationModel> {
  BusinessLocationModelMapper._();

  static BusinessLocationModelMapper? _instance;
  static BusinessLocationModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BusinessLocationModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BusinessLocationModel';

  static String _$address(BusinessLocationModel v) => v.address;
  static const Field<BusinessLocationModel, String> _f$address = Field(
    'address',
    _$address,
  );
  static double _$latitude(BusinessLocationModel v) => v.latitude;
  static const Field<BusinessLocationModel, double> _f$latitude = Field(
    'latitude',
    _$latitude,
  );
  static double _$longitude(BusinessLocationModel v) => v.longitude;
  static const Field<BusinessLocationModel, double> _f$longitude = Field(
    'longitude',
    _$longitude,
  );

  @override
  final MappableFields<BusinessLocationModel> fields = const {
    #address: _f$address,
    #latitude: _f$latitude,
    #longitude: _f$longitude,
  };

  static BusinessLocationModel _instantiate(DecodingData data) {
    return BusinessLocationModel(
      address: data.dec(_f$address),
      latitude: data.dec(_f$latitude),
      longitude: data.dec(_f$longitude),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static BusinessLocationModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BusinessLocationModel>(map);
  }

  static BusinessLocationModel fromJson(String json) {
    return ensureInitialized().decodeJson<BusinessLocationModel>(json);
  }
}

mixin BusinessLocationModelMappable {
  String toJson() {
    return BusinessLocationModelMapper.ensureInitialized()
        .encodeJson<BusinessLocationModel>(this as BusinessLocationModel);
  }

  Map<String, dynamic> toMap() {
    return BusinessLocationModelMapper.ensureInitialized()
        .encodeMap<BusinessLocationModel>(this as BusinessLocationModel);
  }

  BusinessLocationModelCopyWith<
    BusinessLocationModel,
    BusinessLocationModel,
    BusinessLocationModel
  >
  get copyWith =>
      _BusinessLocationModelCopyWithImpl<
        BusinessLocationModel,
        BusinessLocationModel
      >(this as BusinessLocationModel, $identity, $identity);
  @override
  String toString() {
    return BusinessLocationModelMapper.ensureInitialized().stringifyValue(
      this as BusinessLocationModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return BusinessLocationModelMapper.ensureInitialized().equalsValue(
      this as BusinessLocationModel,
      other,
    );
  }

  @override
  int get hashCode {
    return BusinessLocationModelMapper.ensureInitialized().hashValue(
      this as BusinessLocationModel,
    );
  }
}

extension BusinessLocationModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BusinessLocationModel, $Out> {
  BusinessLocationModelCopyWith<$R, BusinessLocationModel, $Out>
  get $asBusinessLocationModel => $base.as(
    (v, t, t2) => _BusinessLocationModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class BusinessLocationModelCopyWith<
  $R,
  $In extends BusinessLocationModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? address, double? latitude, double? longitude});
  BusinessLocationModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _BusinessLocationModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BusinessLocationModel, $Out>
    implements BusinessLocationModelCopyWith<$R, BusinessLocationModel, $Out> {
  _BusinessLocationModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BusinessLocationModel> $mapper =
      BusinessLocationModelMapper.ensureInitialized();
  @override
  $R call({String? address, double? latitude, double? longitude}) => $apply(
    FieldCopyWithData({
      if (address != null) #address: address,
      if (latitude != null) #latitude: latitude,
      if (longitude != null) #longitude: longitude,
    }),
  );
  @override
  BusinessLocationModel $make(CopyWithData data) => BusinessLocationModel(
    address: data.get(#address, or: $value.address),
    latitude: data.get(#latitude, or: $value.latitude),
    longitude: data.get(#longitude, or: $value.longitude),
  );

  @override
  BusinessLocationModelCopyWith<$R2, BusinessLocationModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BusinessLocationModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

