// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'business_review_model.dart';

class BusinessReviewModelMapper extends ClassMapperBase<BusinessReviewModel> {
  BusinessReviewModelMapper._();

  static BusinessReviewModelMapper? _instance;
  static BusinessReviewModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BusinessReviewModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BusinessReviewModel';

  static String _$id(BusinessReviewModel v) => v.id;
  static const Field<BusinessReviewModel, String> _f$id = Field('id', _$id);
  static String _$customerName(BusinessReviewModel v) => v.customerName;
  static const Field<BusinessReviewModel, String> _f$customerName = Field(
    'customerName',
    _$customerName,
  );
  static int _$rating(BusinessReviewModel v) => v.rating;
  static const Field<BusinessReviewModel, int> _f$rating = Field(
    'rating',
    _$rating,
  );
  static String? _$customerAvatarUrl(BusinessReviewModel v) =>
      v.customerAvatarUrl;
  static const Field<BusinessReviewModel, String> _f$customerAvatarUrl = Field(
    'customerAvatarUrl',
    _$customerAvatarUrl,
    opt: true,
  );
  static String? _$comment(BusinessReviewModel v) => v.comment;
  static const Field<BusinessReviewModel, String> _f$comment = Field(
    'comment',
    _$comment,
    opt: true,
  );

  @override
  final MappableFields<BusinessReviewModel> fields = const {
    #id: _f$id,
    #customerName: _f$customerName,
    #rating: _f$rating,
    #customerAvatarUrl: _f$customerAvatarUrl,
    #comment: _f$comment,
  };

  static BusinessReviewModel _instantiate(DecodingData data) {
    return BusinessReviewModel(
      id: data.dec(_f$id),
      customerName: data.dec(_f$customerName),
      rating: data.dec(_f$rating),
      customerAvatarUrl: data.dec(_f$customerAvatarUrl),
      comment: data.dec(_f$comment),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static BusinessReviewModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BusinessReviewModel>(map);
  }

  static BusinessReviewModel fromJson(String json) {
    return ensureInitialized().decodeJson<BusinessReviewModel>(json);
  }
}

mixin BusinessReviewModelMappable {
  String toJson() {
    return BusinessReviewModelMapper.ensureInitialized()
        .encodeJson<BusinessReviewModel>(this as BusinessReviewModel);
  }

  Map<String, dynamic> toMap() {
    return BusinessReviewModelMapper.ensureInitialized()
        .encodeMap<BusinessReviewModel>(this as BusinessReviewModel);
  }

  BusinessReviewModelCopyWith<
    BusinessReviewModel,
    BusinessReviewModel,
    BusinessReviewModel
  >
  get copyWith =>
      _BusinessReviewModelCopyWithImpl<
        BusinessReviewModel,
        BusinessReviewModel
      >(this as BusinessReviewModel, $identity, $identity);
  @override
  String toString() {
    return BusinessReviewModelMapper.ensureInitialized().stringifyValue(
      this as BusinessReviewModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return BusinessReviewModelMapper.ensureInitialized().equalsValue(
      this as BusinessReviewModel,
      other,
    );
  }

  @override
  int get hashCode {
    return BusinessReviewModelMapper.ensureInitialized().hashValue(
      this as BusinessReviewModel,
    );
  }
}

extension BusinessReviewModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BusinessReviewModel, $Out> {
  BusinessReviewModelCopyWith<$R, BusinessReviewModel, $Out>
  get $asBusinessReviewModel => $base.as(
    (v, t, t2) => _BusinessReviewModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class BusinessReviewModelCopyWith<
  $R,
  $In extends BusinessReviewModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? customerName,
    int? rating,
    String? customerAvatarUrl,
    String? comment,
  });
  BusinessReviewModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _BusinessReviewModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BusinessReviewModel, $Out>
    implements BusinessReviewModelCopyWith<$R, BusinessReviewModel, $Out> {
  _BusinessReviewModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BusinessReviewModel> $mapper =
      BusinessReviewModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? customerName,
    int? rating,
    Object? customerAvatarUrl = $none,
    Object? comment = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (customerName != null) #customerName: customerName,
      if (rating != null) #rating: rating,
      if (customerAvatarUrl != $none) #customerAvatarUrl: customerAvatarUrl,
      if (comment != $none) #comment: comment,
    }),
  );
  @override
  BusinessReviewModel $make(CopyWithData data) => BusinessReviewModel(
    id: data.get(#id, or: $value.id),
    customerName: data.get(#customerName, or: $value.customerName),
    rating: data.get(#rating, or: $value.rating),
    customerAvatarUrl: data.get(
      #customerAvatarUrl,
      or: $value.customerAvatarUrl,
    ),
    comment: data.get(#comment, or: $value.comment),
  );

  @override
  BusinessReviewModelCopyWith<$R2, BusinessReviewModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BusinessReviewModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

