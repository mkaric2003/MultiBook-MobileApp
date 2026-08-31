// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'booking_extra_request.dart';

class BookingExtraRequestMapper extends ClassMapperBase<BookingExtraRequest> {
  BookingExtraRequestMapper._();

  static BookingExtraRequestMapper? _instance;
  static BookingExtraRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BookingExtraRequestMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BookingExtraRequest';

  static String _$type(BookingExtraRequest v) => v.type;
  static const Field<BookingExtraRequest, String> _f$type = Field(
    'type',
    _$type,
  );

  @override
  final MappableFields<BookingExtraRequest> fields = const {#type: _f$type};

  static BookingExtraRequest _instantiate(DecodingData data) {
    return BookingExtraRequest(type: data.dec(_f$type));
  }

  @override
  final Function instantiate = _instantiate;

  static BookingExtraRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BookingExtraRequest>(map);
  }

  static BookingExtraRequest fromJson(String json) {
    return ensureInitialized().decodeJson<BookingExtraRequest>(json);
  }
}

mixin BookingExtraRequestMappable {
  String toJson() {
    return BookingExtraRequestMapper.ensureInitialized()
        .encodeJson<BookingExtraRequest>(this as BookingExtraRequest);
  }

  Map<String, dynamic> toMap() {
    return BookingExtraRequestMapper.ensureInitialized()
        .encodeMap<BookingExtraRequest>(this as BookingExtraRequest);
  }

  BookingExtraRequestCopyWith<
    BookingExtraRequest,
    BookingExtraRequest,
    BookingExtraRequest
  >
  get copyWith =>
      _BookingExtraRequestCopyWithImpl<
        BookingExtraRequest,
        BookingExtraRequest
      >(this as BookingExtraRequest, $identity, $identity);
  @override
  String toString() {
    return BookingExtraRequestMapper.ensureInitialized().stringifyValue(
      this as BookingExtraRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return BookingExtraRequestMapper.ensureInitialized().equalsValue(
      this as BookingExtraRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return BookingExtraRequestMapper.ensureInitialized().hashValue(
      this as BookingExtraRequest,
    );
  }
}

extension BookingExtraRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BookingExtraRequest, $Out> {
  BookingExtraRequestCopyWith<$R, BookingExtraRequest, $Out>
  get $asBookingExtraRequest => $base.as(
    (v, t, t2) => _BookingExtraRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class BookingExtraRequestCopyWith<
  $R,
  $In extends BookingExtraRequest,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? type});
  BookingExtraRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _BookingExtraRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BookingExtraRequest, $Out>
    implements BookingExtraRequestCopyWith<$R, BookingExtraRequest, $Out> {
  _BookingExtraRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BookingExtraRequest> $mapper =
      BookingExtraRequestMapper.ensureInitialized();
  @override
  $R call({String? type}) =>
      $apply(FieldCopyWithData({if (type != null) #type: type}));
  @override
  BookingExtraRequest $make(CopyWithData data) =>
      BookingExtraRequest(type: data.get(#type, or: $value.type));

  @override
  BookingExtraRequestCopyWith<$R2, BookingExtraRequest, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BookingExtraRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

