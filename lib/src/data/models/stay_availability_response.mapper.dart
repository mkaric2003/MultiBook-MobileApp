// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'stay_availability_response.dart';

class StayAvailabilityResponseMapper
    extends ClassMapperBase<StayAvailabilityResponse> {
  StayAvailabilityResponseMapper._();

  static StayAvailabilityResponseMapper? _instance;
  static StayAvailabilityResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = StayAvailabilityResponseMapper._(),
      );
      StayUnavailableRangeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'StayAvailabilityResponse';

  static List<StayUnavailableRange> _$unavailableRanges(
    StayAvailabilityResponse v,
  ) => v.unavailableRanges;
  static const Field<StayAvailabilityResponse, List<StayUnavailableRange>>
  _f$unavailableRanges = Field('unavailableRanges', _$unavailableRanges);

  @override
  final MappableFields<StayAvailabilityResponse> fields = const {
    #unavailableRanges: _f$unavailableRanges,
  };

  static StayAvailabilityResponse _instantiate(DecodingData data) {
    return StayAvailabilityResponse(
      unavailableRanges: data.dec(_f$unavailableRanges),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static StayAvailabilityResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StayAvailabilityResponse>(map);
  }

  static StayAvailabilityResponse fromJson(String json) {
    return ensureInitialized().decodeJson<StayAvailabilityResponse>(json);
  }
}

mixin StayAvailabilityResponseMappable {
  String toJson() {
    return StayAvailabilityResponseMapper.ensureInitialized()
        .encodeJson<StayAvailabilityResponse>(this as StayAvailabilityResponse);
  }

  Map<String, dynamic> toMap() {
    return StayAvailabilityResponseMapper.ensureInitialized()
        .encodeMap<StayAvailabilityResponse>(this as StayAvailabilityResponse);
  }

  StayAvailabilityResponseCopyWith<
    StayAvailabilityResponse,
    StayAvailabilityResponse,
    StayAvailabilityResponse
  >
  get copyWith =>
      _StayAvailabilityResponseCopyWithImpl<
        StayAvailabilityResponse,
        StayAvailabilityResponse
      >(this as StayAvailabilityResponse, $identity, $identity);
  @override
  String toString() {
    return StayAvailabilityResponseMapper.ensureInitialized().stringifyValue(
      this as StayAvailabilityResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return StayAvailabilityResponseMapper.ensureInitialized().equalsValue(
      this as StayAvailabilityResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return StayAvailabilityResponseMapper.ensureInitialized().hashValue(
      this as StayAvailabilityResponse,
    );
  }
}

extension StayAvailabilityResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StayAvailabilityResponse, $Out> {
  StayAvailabilityResponseCopyWith<$R, StayAvailabilityResponse, $Out>
  get $asStayAvailabilityResponse => $base.as(
    (v, t, t2) => _StayAvailabilityResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class StayAvailabilityResponseCopyWith<
  $R,
  $In extends StayAvailabilityResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    StayUnavailableRange,
    StayUnavailableRangeCopyWith<$R, StayUnavailableRange, StayUnavailableRange>
  >
  get unavailableRanges;
  $R call({List<StayUnavailableRange>? unavailableRanges});
  StayAvailabilityResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _StayAvailabilityResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StayAvailabilityResponse, $Out>
    implements
        StayAvailabilityResponseCopyWith<$R, StayAvailabilityResponse, $Out> {
  _StayAvailabilityResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StayAvailabilityResponse> $mapper =
      StayAvailabilityResponseMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    StayUnavailableRange,
    StayUnavailableRangeCopyWith<$R, StayUnavailableRange, StayUnavailableRange>
  >
  get unavailableRanges => ListCopyWith(
    $value.unavailableRanges,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(unavailableRanges: v),
  );
  @override
  $R call({List<StayUnavailableRange>? unavailableRanges}) => $apply(
    FieldCopyWithData({
      if (unavailableRanges != null) #unavailableRanges: unavailableRanges,
    }),
  );
  @override
  StayAvailabilityResponse $make(CopyWithData data) => StayAvailabilityResponse(
    unavailableRanges: data.get(
      #unavailableRanges,
      or: $value.unavailableRanges,
    ),
  );

  @override
  StayAvailabilityResponseCopyWith<$R2, StayAvailabilityResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _StayAvailabilityResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

