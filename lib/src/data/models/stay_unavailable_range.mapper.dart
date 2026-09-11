// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'stay_unavailable_range.dart';

class StayUnavailableRangeMapper extends ClassMapperBase<StayUnavailableRange> {
  StayUnavailableRangeMapper._();

  static StayUnavailableRangeMapper? _instance;
  static StayUnavailableRangeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StayUnavailableRangeMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'StayUnavailableRange';

  static DateTime _$checkIn(StayUnavailableRange v) => v.checkIn;
  static const Field<StayUnavailableRange, DateTime> _f$checkIn = Field(
    'checkIn',
    _$checkIn,
  );
  static DateTime _$checkOut(StayUnavailableRange v) => v.checkOut;
  static const Field<StayUnavailableRange, DateTime> _f$checkOut = Field(
    'checkOut',
    _$checkOut,
  );

  @override
  final MappableFields<StayUnavailableRange> fields = const {
    #checkIn: _f$checkIn,
    #checkOut: _f$checkOut,
  };

  static StayUnavailableRange _instantiate(DecodingData data) {
    return StayUnavailableRange(
      checkIn: data.dec(_f$checkIn),
      checkOut: data.dec(_f$checkOut),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static StayUnavailableRange fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StayUnavailableRange>(map);
  }

  static StayUnavailableRange fromJson(String json) {
    return ensureInitialized().decodeJson<StayUnavailableRange>(json);
  }
}

mixin StayUnavailableRangeMappable {
  String toJson() {
    return StayUnavailableRangeMapper.ensureInitialized()
        .encodeJson<StayUnavailableRange>(this as StayUnavailableRange);
  }

  Map<String, dynamic> toMap() {
    return StayUnavailableRangeMapper.ensureInitialized()
        .encodeMap<StayUnavailableRange>(this as StayUnavailableRange);
  }

  StayUnavailableRangeCopyWith<
    StayUnavailableRange,
    StayUnavailableRange,
    StayUnavailableRange
  >
  get copyWith =>
      _StayUnavailableRangeCopyWithImpl<
        StayUnavailableRange,
        StayUnavailableRange
      >(this as StayUnavailableRange, $identity, $identity);
  @override
  String toString() {
    return StayUnavailableRangeMapper.ensureInitialized().stringifyValue(
      this as StayUnavailableRange,
    );
  }

  @override
  bool operator ==(Object other) {
    return StayUnavailableRangeMapper.ensureInitialized().equalsValue(
      this as StayUnavailableRange,
      other,
    );
  }

  @override
  int get hashCode {
    return StayUnavailableRangeMapper.ensureInitialized().hashValue(
      this as StayUnavailableRange,
    );
  }
}

extension StayUnavailableRangeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StayUnavailableRange, $Out> {
  StayUnavailableRangeCopyWith<$R, StayUnavailableRange, $Out>
  get $asStayUnavailableRange => $base.as(
    (v, t, t2) => _StayUnavailableRangeCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class StayUnavailableRangeCopyWith<
  $R,
  $In extends StayUnavailableRange,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({DateTime? checkIn, DateTime? checkOut});
  StayUnavailableRangeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _StayUnavailableRangeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StayUnavailableRange, $Out>
    implements StayUnavailableRangeCopyWith<$R, StayUnavailableRange, $Out> {
  _StayUnavailableRangeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StayUnavailableRange> $mapper =
      StayUnavailableRangeMapper.ensureInitialized();
  @override
  $R call({DateTime? checkIn, DateTime? checkOut}) => $apply(
    FieldCopyWithData({
      if (checkIn != null) #checkIn: checkIn,
      if (checkOut != null) #checkOut: checkOut,
    }),
  );
  @override
  StayUnavailableRange $make(CopyWithData data) => StayUnavailableRange(
    checkIn: data.get(#checkIn, or: $value.checkIn),
    checkOut: data.get(#checkOut, or: $value.checkOut),
  );

  @override
  StayUnavailableRangeCopyWith<$R2, StayUnavailableRange, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _StayUnavailableRangeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

