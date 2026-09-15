// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'help_article_model.dart';

class HelpArticleModelMapper extends ClassMapperBase<HelpArticleModel> {
  HelpArticleModelMapper._();

  static HelpArticleModelMapper? _instance;
  static HelpArticleModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HelpArticleModelMapper._());
      HelpArticleIdMapper.ensureInitialized();
      HelpCenterTopicMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HelpArticleModel';

  static HelpArticleId _$id(HelpArticleModel v) => v.id;
  static const Field<HelpArticleModel, HelpArticleId> _f$id = Field('id', _$id);
  static HelpCenterTopic _$topic(HelpArticleModel v) => v.topic;
  static const Field<HelpArticleModel, HelpCenterTopic> _f$topic = Field(
    'topic',
    _$topic,
  );

  @override
  final MappableFields<HelpArticleModel> fields = const {
    #id: _f$id,
    #topic: _f$topic,
  };

  static HelpArticleModel _instantiate(DecodingData data) {
    return HelpArticleModel(id: data.dec(_f$id), topic: data.dec(_f$topic));
  }

  @override
  final Function instantiate = _instantiate;

  static HelpArticleModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HelpArticleModel>(map);
  }

  static HelpArticleModel fromJson(String json) {
    return ensureInitialized().decodeJson<HelpArticleModel>(json);
  }
}

mixin HelpArticleModelMappable {
  String toJson() {
    return HelpArticleModelMapper.ensureInitialized()
        .encodeJson<HelpArticleModel>(this as HelpArticleModel);
  }

  Map<String, dynamic> toMap() {
    return HelpArticleModelMapper.ensureInitialized()
        .encodeMap<HelpArticleModel>(this as HelpArticleModel);
  }

  HelpArticleModelCopyWith<HelpArticleModel, HelpArticleModel, HelpArticleModel>
  get copyWith =>
      _HelpArticleModelCopyWithImpl<HelpArticleModel, HelpArticleModel>(
        this as HelpArticleModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return HelpArticleModelMapper.ensureInitialized().stringifyValue(
      this as HelpArticleModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return HelpArticleModelMapper.ensureInitialized().equalsValue(
      this as HelpArticleModel,
      other,
    );
  }

  @override
  int get hashCode {
    return HelpArticleModelMapper.ensureInitialized().hashValue(
      this as HelpArticleModel,
    );
  }
}

extension HelpArticleModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HelpArticleModel, $Out> {
  HelpArticleModelCopyWith<$R, HelpArticleModel, $Out>
  get $asHelpArticleModel =>
      $base.as((v, t, t2) => _HelpArticleModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HelpArticleModelCopyWith<$R, $In extends HelpArticleModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({HelpArticleId? id, HelpCenterTopic? topic});
  HelpArticleModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _HelpArticleModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HelpArticleModel, $Out>
    implements HelpArticleModelCopyWith<$R, HelpArticleModel, $Out> {
  _HelpArticleModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HelpArticleModel> $mapper =
      HelpArticleModelMapper.ensureInitialized();
  @override
  $R call({HelpArticleId? id, HelpCenterTopic? topic}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (topic != null) #topic: topic,
    }),
  );
  @override
  HelpArticleModel $make(CopyWithData data) => HelpArticleModel(
    id: data.get(#id, or: $value.id),
    topic: data.get(#topic, or: $value.topic),
  );

  @override
  HelpArticleModelCopyWith<$R2, HelpArticleModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HelpArticleModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

