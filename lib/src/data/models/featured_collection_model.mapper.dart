// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'featured_collection_model.dart';

class FeaturedCollectionModelMapper
    extends ClassMapperBase<FeaturedCollectionModel> {
  FeaturedCollectionModelMapper._();

  static FeaturedCollectionModelMapper? _instance;
  static FeaturedCollectionModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = FeaturedCollectionModelMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'FeaturedCollectionModel';

  static String _$id(FeaturedCollectionModel v) => v.id;
  static const Field<FeaturedCollectionModel, String> _f$id = Field('id', _$id);
  static String _$titleKey(FeaturedCollectionModel v) => v.titleKey;
  static const Field<FeaturedCollectionModel, String> _f$titleKey = Field(
    'titleKey',
    _$titleKey,
  );
  static String _$subtitleKey(FeaturedCollectionModel v) => v.subtitleKey;
  static const Field<FeaturedCollectionModel, String> _f$subtitleKey = Field(
    'subtitleKey',
    _$subtitleKey,
  );
  static String _$imageUrl(FeaturedCollectionModel v) => v.imageUrl;
  static const Field<FeaturedCollectionModel, String> _f$imageUrl = Field(
    'imageUrl',
    _$imageUrl,
  );

  @override
  final MappableFields<FeaturedCollectionModel> fields = const {
    #id: _f$id,
    #titleKey: _f$titleKey,
    #subtitleKey: _f$subtitleKey,
    #imageUrl: _f$imageUrl,
  };

  static FeaturedCollectionModel _instantiate(DecodingData data) {
    return FeaturedCollectionModel(
      id: data.dec(_f$id),
      titleKey: data.dec(_f$titleKey),
      subtitleKey: data.dec(_f$subtitleKey),
      imageUrl: data.dec(_f$imageUrl),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static FeaturedCollectionModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FeaturedCollectionModel>(map);
  }

  static FeaturedCollectionModel fromJson(String json) {
    return ensureInitialized().decodeJson<FeaturedCollectionModel>(json);
  }
}

mixin FeaturedCollectionModelMappable {
  String toJson() {
    return FeaturedCollectionModelMapper.ensureInitialized()
        .encodeJson<FeaturedCollectionModel>(this as FeaturedCollectionModel);
  }

  Map<String, dynamic> toMap() {
    return FeaturedCollectionModelMapper.ensureInitialized()
        .encodeMap<FeaturedCollectionModel>(this as FeaturedCollectionModel);
  }

  FeaturedCollectionModelCopyWith<
    FeaturedCollectionModel,
    FeaturedCollectionModel,
    FeaturedCollectionModel
  >
  get copyWith =>
      _FeaturedCollectionModelCopyWithImpl<
        FeaturedCollectionModel,
        FeaturedCollectionModel
      >(this as FeaturedCollectionModel, $identity, $identity);
  @override
  String toString() {
    return FeaturedCollectionModelMapper.ensureInitialized().stringifyValue(
      this as FeaturedCollectionModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return FeaturedCollectionModelMapper.ensureInitialized().equalsValue(
      this as FeaturedCollectionModel,
      other,
    );
  }

  @override
  int get hashCode {
    return FeaturedCollectionModelMapper.ensureInitialized().hashValue(
      this as FeaturedCollectionModel,
    );
  }
}

extension FeaturedCollectionModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FeaturedCollectionModel, $Out> {
  FeaturedCollectionModelCopyWith<$R, FeaturedCollectionModel, $Out>
  get $asFeaturedCollectionModel => $base.as(
    (v, t, t2) => _FeaturedCollectionModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class FeaturedCollectionModelCopyWith<
  $R,
  $In extends FeaturedCollectionModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? titleKey,
    String? subtitleKey,
    String? imageUrl,
  });
  FeaturedCollectionModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _FeaturedCollectionModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FeaturedCollectionModel, $Out>
    implements
        FeaturedCollectionModelCopyWith<$R, FeaturedCollectionModel, $Out> {
  _FeaturedCollectionModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FeaturedCollectionModel> $mapper =
      FeaturedCollectionModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? titleKey,
    String? subtitleKey,
    String? imageUrl,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (titleKey != null) #titleKey: titleKey,
      if (subtitleKey != null) #subtitleKey: subtitleKey,
      if (imageUrl != null) #imageUrl: imageUrl,
    }),
  );
  @override
  FeaturedCollectionModel $make(CopyWithData data) => FeaturedCollectionModel(
    id: data.get(#id, or: $value.id),
    titleKey: data.get(#titleKey, or: $value.titleKey),
    subtitleKey: data.get(#subtitleKey, or: $value.subtitleKey),
    imageUrl: data.get(#imageUrl, or: $value.imageUrl),
  );

  @override
  FeaturedCollectionModelCopyWith<$R2, FeaturedCollectionModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FeaturedCollectionModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

