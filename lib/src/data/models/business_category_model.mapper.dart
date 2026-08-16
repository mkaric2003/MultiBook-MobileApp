// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'business_category_model.dart';

class BusinessCategoryModelMapper
    extends ClassMapperBase<BusinessCategoryModel> {
  BusinessCategoryModelMapper._();

  static BusinessCategoryModelMapper? _instance;
  static BusinessCategoryModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BusinessCategoryModelMapper._());
      BusinessTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BusinessCategoryModel';

  static String _$id(BusinessCategoryModel v) => v.id;
  static const Field<BusinessCategoryModel, String> _f$id = Field('id', _$id);
  static String _$name(BusinessCategoryModel v) => v.name;
  static const Field<BusinessCategoryModel, String> _f$name = Field(
    'name',
    _$name,
  );
  static BusinessType _$type(BusinessCategoryModel v) => v.type;
  static const Field<BusinessCategoryModel, BusinessType> _f$type = Field(
    'type',
    _$type,
  );

  @override
  final MappableFields<BusinessCategoryModel> fields = const {
    #id: _f$id,
    #name: _f$name,
    #type: _f$type,
  };

  static BusinessCategoryModel _instantiate(DecodingData data) {
    return BusinessCategoryModel(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      type: data.dec(_f$type),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static BusinessCategoryModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BusinessCategoryModel>(map);
  }

  static BusinessCategoryModel fromJson(String json) {
    return ensureInitialized().decodeJson<BusinessCategoryModel>(json);
  }
}

mixin BusinessCategoryModelMappable {
  String toJson() {
    return BusinessCategoryModelMapper.ensureInitialized()
        .encodeJson<BusinessCategoryModel>(this as BusinessCategoryModel);
  }

  Map<String, dynamic> toMap() {
    return BusinessCategoryModelMapper.ensureInitialized()
        .encodeMap<BusinessCategoryModel>(this as BusinessCategoryModel);
  }

  BusinessCategoryModelCopyWith<
    BusinessCategoryModel,
    BusinessCategoryModel,
    BusinessCategoryModel
  >
  get copyWith =>
      _BusinessCategoryModelCopyWithImpl<
        BusinessCategoryModel,
        BusinessCategoryModel
      >(this as BusinessCategoryModel, $identity, $identity);
  @override
  String toString() {
    return BusinessCategoryModelMapper.ensureInitialized().stringifyValue(
      this as BusinessCategoryModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return BusinessCategoryModelMapper.ensureInitialized().equalsValue(
      this as BusinessCategoryModel,
      other,
    );
  }

  @override
  int get hashCode {
    return BusinessCategoryModelMapper.ensureInitialized().hashValue(
      this as BusinessCategoryModel,
    );
  }
}

extension BusinessCategoryModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BusinessCategoryModel, $Out> {
  BusinessCategoryModelCopyWith<$R, BusinessCategoryModel, $Out>
  get $asBusinessCategoryModel => $base.as(
    (v, t, t2) => _BusinessCategoryModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class BusinessCategoryModelCopyWith<
  $R,
  $In extends BusinessCategoryModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name, BusinessType? type});
  BusinessCategoryModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _BusinessCategoryModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BusinessCategoryModel, $Out>
    implements BusinessCategoryModelCopyWith<$R, BusinessCategoryModel, $Out> {
  _BusinessCategoryModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BusinessCategoryModel> $mapper =
      BusinessCategoryModelMapper.ensureInitialized();
  @override
  $R call({String? id, String? name, BusinessType? type}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (type != null) #type: type,
    }),
  );
  @override
  BusinessCategoryModel $make(CopyWithData data) => BusinessCategoryModel(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    type: data.get(#type, or: $value.type),
  );

  @override
  BusinessCategoryModelCopyWith<$R2, BusinessCategoryModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BusinessCategoryModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

