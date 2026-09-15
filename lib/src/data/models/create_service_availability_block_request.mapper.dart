// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'create_service_availability_block_request.dart';

class CreateServiceAvailabilityBlockRequestMapper
    extends ClassMapperBase<CreateServiceAvailabilityBlockRequest> {
  CreateServiceAvailabilityBlockRequestMapper._();

  static CreateServiceAvailabilityBlockRequestMapper? _instance;
  static CreateServiceAvailabilityBlockRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = CreateServiceAvailabilityBlockRequestMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'CreateServiceAvailabilityBlockRequest';

  static DateTime _$startAt(CreateServiceAvailabilityBlockRequest v) =>
      v.startAt;
  static const Field<CreateServiceAvailabilityBlockRequest, DateTime>
  _f$startAt = Field('startAt', _$startAt, key: r'start_at');
  static DateTime _$endAt(CreateServiceAvailabilityBlockRequest v) => v.endAt;
  static const Field<CreateServiceAvailabilityBlockRequest, DateTime> _f$endAt =
      Field('endAt', _$endAt, key: r'end_at');
  static String? _$reason(CreateServiceAvailabilityBlockRequest v) => v.reason;
  static const Field<CreateServiceAvailabilityBlockRequest, String> _f$reason =
      Field('reason', _$reason, opt: true);

  @override
  final MappableFields<CreateServiceAvailabilityBlockRequest> fields = const {
    #startAt: _f$startAt,
    #endAt: _f$endAt,
    #reason: _f$reason,
  };

  static CreateServiceAvailabilityBlockRequest _instantiate(DecodingData data) {
    return CreateServiceAvailabilityBlockRequest(
      startAt: data.dec(_f$startAt),
      endAt: data.dec(_f$endAt),
      reason: data.dec(_f$reason),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CreateServiceAvailabilityBlockRequest fromMap(
    Map<String, dynamic> map,
  ) {
    return ensureInitialized().decodeMap<CreateServiceAvailabilityBlockRequest>(
      map,
    );
  }

  static CreateServiceAvailabilityBlockRequest fromJson(String json) {
    return ensureInitialized()
        .decodeJson<CreateServiceAvailabilityBlockRequest>(json);
  }
}

mixin CreateServiceAvailabilityBlockRequestMappable {
  String toJson() {
    return CreateServiceAvailabilityBlockRequestMapper.ensureInitialized()
        .encodeJson<CreateServiceAvailabilityBlockRequest>(
          this as CreateServiceAvailabilityBlockRequest,
        );
  }

  Map<String, dynamic> toMap() {
    return CreateServiceAvailabilityBlockRequestMapper.ensureInitialized()
        .encodeMap<CreateServiceAvailabilityBlockRequest>(
          this as CreateServiceAvailabilityBlockRequest,
        );
  }

  CreateServiceAvailabilityBlockRequestCopyWith<
    CreateServiceAvailabilityBlockRequest,
    CreateServiceAvailabilityBlockRequest,
    CreateServiceAvailabilityBlockRequest
  >
  get copyWith =>
      _CreateServiceAvailabilityBlockRequestCopyWithImpl<
        CreateServiceAvailabilityBlockRequest,
        CreateServiceAvailabilityBlockRequest
      >(this as CreateServiceAvailabilityBlockRequest, $identity, $identity);
  @override
  String toString() {
    return CreateServiceAvailabilityBlockRequestMapper.ensureInitialized()
        .stringifyValue(this as CreateServiceAvailabilityBlockRequest);
  }

  @override
  bool operator ==(Object other) {
    return CreateServiceAvailabilityBlockRequestMapper.ensureInitialized()
        .equalsValue(this as CreateServiceAvailabilityBlockRequest, other);
  }

  @override
  int get hashCode {
    return CreateServiceAvailabilityBlockRequestMapper.ensureInitialized()
        .hashValue(this as CreateServiceAvailabilityBlockRequest);
  }
}

extension CreateServiceAvailabilityBlockRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CreateServiceAvailabilityBlockRequest, $Out> {
  CreateServiceAvailabilityBlockRequestCopyWith<
    $R,
    CreateServiceAvailabilityBlockRequest,
    $Out
  >
  get $asCreateServiceAvailabilityBlockRequest => $base.as(
    (v, t, t2) =>
        _CreateServiceAvailabilityBlockRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CreateServiceAvailabilityBlockRequestCopyWith<
  $R,
  $In extends CreateServiceAvailabilityBlockRequest,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({DateTime? startAt, DateTime? endAt, String? reason});
  CreateServiceAvailabilityBlockRequestCopyWith<$R2, $In, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CreateServiceAvailabilityBlockRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CreateServiceAvailabilityBlockRequest, $Out>
    implements
        CreateServiceAvailabilityBlockRequestCopyWith<
          $R,
          CreateServiceAvailabilityBlockRequest,
          $Out
        > {
  _CreateServiceAvailabilityBlockRequestCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<CreateServiceAvailabilityBlockRequest> $mapper =
      CreateServiceAvailabilityBlockRequestMapper.ensureInitialized();
  @override
  $R call({DateTime? startAt, DateTime? endAt, Object? reason = $none}) =>
      $apply(
        FieldCopyWithData({
          if (startAt != null) #startAt: startAt,
          if (endAt != null) #endAt: endAt,
          if (reason != $none) #reason: reason,
        }),
      );
  @override
  CreateServiceAvailabilityBlockRequest $make(CopyWithData data) =>
      CreateServiceAvailabilityBlockRequest(
        startAt: data.get(#startAt, or: $value.startAt),
        endAt: data.get(#endAt, or: $value.endAt),
        reason: data.get(#reason, or: $value.reason),
      );

  @override
  CreateServiceAvailabilityBlockRequestCopyWith<
    $R2,
    CreateServiceAvailabilityBlockRequest,
    $Out2
  >
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CreateServiceAvailabilityBlockRequestCopyWithImpl<$R2, $Out2>(
        $value,
        $cast,
        t,
      );
}

