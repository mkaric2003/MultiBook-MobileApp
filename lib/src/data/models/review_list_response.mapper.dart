// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'review_list_response.dart';

class ReviewListResponseMapper extends ClassMapperBase<ReviewListResponse> {
  ReviewListResponseMapper._();

  static ReviewListResponseMapper? _instance;
  static ReviewListResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ReviewListResponseMapper._());
      BusinessReviewModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ReviewListResponse';

  static List<BusinessReviewModel> _$items(ReviewListResponse v) => v.items;
  static const Field<ReviewListResponse, List<BusinessReviewModel>> _f$items =
      Field('items', _$items);
  static int? _$nextOffset(ReviewListResponse v) => v.nextOffset;
  static const Field<ReviewListResponse, int> _f$nextOffset = Field(
    'nextOffset',
    _$nextOffset,
    opt: true,
  );

  @override
  final MappableFields<ReviewListResponse> fields = const {
    #items: _f$items,
    #nextOffset: _f$nextOffset,
  };

  static ReviewListResponse _instantiate(DecodingData data) {
    return ReviewListResponse(
      items: data.dec(_f$items),
      nextOffset: data.dec(_f$nextOffset),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ReviewListResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ReviewListResponse>(map);
  }

  static ReviewListResponse fromJson(String json) {
    return ensureInitialized().decodeJson<ReviewListResponse>(json);
  }
}

mixin ReviewListResponseMappable {
  String toJson() {
    return ReviewListResponseMapper.ensureInitialized()
        .encodeJson<ReviewListResponse>(this as ReviewListResponse);
  }

  Map<String, dynamic> toMap() {
    return ReviewListResponseMapper.ensureInitialized()
        .encodeMap<ReviewListResponse>(this as ReviewListResponse);
  }

  ReviewListResponseCopyWith<
    ReviewListResponse,
    ReviewListResponse,
    ReviewListResponse
  >
  get copyWith =>
      _ReviewListResponseCopyWithImpl<ReviewListResponse, ReviewListResponse>(
        this as ReviewListResponse,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ReviewListResponseMapper.ensureInitialized().stringifyValue(
      this as ReviewListResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return ReviewListResponseMapper.ensureInitialized().equalsValue(
      this as ReviewListResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return ReviewListResponseMapper.ensureInitialized().hashValue(
      this as ReviewListResponse,
    );
  }
}

extension ReviewListResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ReviewListResponse, $Out> {
  ReviewListResponseCopyWith<$R, ReviewListResponse, $Out>
  get $asReviewListResponse => $base.as(
    (v, t, t2) => _ReviewListResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ReviewListResponseCopyWith<
  $R,
  $In extends ReviewListResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    BusinessReviewModel,
    BusinessReviewModelCopyWith<$R, BusinessReviewModel, BusinessReviewModel>
  >
  get items;
  $R call({List<BusinessReviewModel>? items, int? nextOffset});
  ReviewListResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ReviewListResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ReviewListResponse, $Out>
    implements ReviewListResponseCopyWith<$R, ReviewListResponse, $Out> {
  _ReviewListResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ReviewListResponse> $mapper =
      ReviewListResponseMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    BusinessReviewModel,
    BusinessReviewModelCopyWith<$R, BusinessReviewModel, BusinessReviewModel>
  >
  get items => ListCopyWith(
    $value.items,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(items: v),
  );
  @override
  $R call({List<BusinessReviewModel>? items, Object? nextOffset = $none}) =>
      $apply(
        FieldCopyWithData({
          if (items != null) #items: items,
          if (nextOffset != $none) #nextOffset: nextOffset,
        }),
      );
  @override
  ReviewListResponse $make(CopyWithData data) => ReviewListResponse(
    items: data.get(#items, or: $value.items),
    nextOffset: data.get(#nextOffset, or: $value.nextOffset),
  );

  @override
  ReviewListResponseCopyWith<$R2, ReviewListResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ReviewListResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

