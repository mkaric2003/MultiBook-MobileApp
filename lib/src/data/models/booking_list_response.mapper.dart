// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'booking_list_response.dart';

class BookingListResponseMapper extends ClassMapperBase<BookingListResponse> {
  BookingListResponseMapper._();

  static BookingListResponseMapper? _instance;
  static BookingListResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BookingListResponseMapper._());
      BookingModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BookingListResponse';

  static List<BookingModel> _$items(BookingListResponse v) => v.items;
  static const Field<BookingListResponse, List<BookingModel>> _f$items = Field(
    'items',
    _$items,
  );
  static String? _$nextCursor(BookingListResponse v) => v.nextCursor;
  static const Field<BookingListResponse, String> _f$nextCursor = Field(
    'nextCursor',
    _$nextCursor,
    opt: true,
  );

  @override
  final MappableFields<BookingListResponse> fields = const {
    #items: _f$items,
    #nextCursor: _f$nextCursor,
  };

  static BookingListResponse _instantiate(DecodingData data) {
    return BookingListResponse(
      items: data.dec(_f$items),
      nextCursor: data.dec(_f$nextCursor),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static BookingListResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BookingListResponse>(map);
  }

  static BookingListResponse fromJson(String json) {
    return ensureInitialized().decodeJson<BookingListResponse>(json);
  }
}

mixin BookingListResponseMappable {
  String toJson() {
    return BookingListResponseMapper.ensureInitialized()
        .encodeJson<BookingListResponse>(this as BookingListResponse);
  }

  Map<String, dynamic> toMap() {
    return BookingListResponseMapper.ensureInitialized()
        .encodeMap<BookingListResponse>(this as BookingListResponse);
  }

  BookingListResponseCopyWith<
    BookingListResponse,
    BookingListResponse,
    BookingListResponse
  >
  get copyWith =>
      _BookingListResponseCopyWithImpl<
        BookingListResponse,
        BookingListResponse
      >(this as BookingListResponse, $identity, $identity);
  @override
  String toString() {
    return BookingListResponseMapper.ensureInitialized().stringifyValue(
      this as BookingListResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return BookingListResponseMapper.ensureInitialized().equalsValue(
      this as BookingListResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return BookingListResponseMapper.ensureInitialized().hashValue(
      this as BookingListResponse,
    );
  }
}

extension BookingListResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BookingListResponse, $Out> {
  BookingListResponseCopyWith<$R, BookingListResponse, $Out>
  get $asBookingListResponse => $base.as(
    (v, t, t2) => _BookingListResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class BookingListResponseCopyWith<
  $R,
  $In extends BookingListResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    BookingModel,
    BookingModelCopyWith<$R, BookingModel, BookingModel>
  >
  get items;
  $R call({List<BookingModel>? items, String? nextCursor});
  BookingListResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _BookingListResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BookingListResponse, $Out>
    implements BookingListResponseCopyWith<$R, BookingListResponse, $Out> {
  _BookingListResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BookingListResponse> $mapper =
      BookingListResponseMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    BookingModel,
    BookingModelCopyWith<$R, BookingModel, BookingModel>
  >
  get items => ListCopyWith(
    $value.items,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(items: v),
  );
  @override
  $R call({List<BookingModel>? items, Object? nextCursor = $none}) => $apply(
    FieldCopyWithData({
      if (items != null) #items: items,
      if (nextCursor != $none) #nextCursor: nextCursor,
    }),
  );
  @override
  BookingListResponse $make(CopyWithData data) => BookingListResponse(
    items: data.get(#items, or: $value.items),
    nextCursor: data.get(#nextCursor, or: $value.nextCursor),
  );

  @override
  BookingListResponseCopyWith<$R2, BookingListResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BookingListResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

