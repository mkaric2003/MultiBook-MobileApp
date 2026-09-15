// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'reschedule_appointment_request.dart';

class RescheduleAppointmentRequestMapper
    extends ClassMapperBase<RescheduleAppointmentRequest> {
  RescheduleAppointmentRequestMapper._();

  static RescheduleAppointmentRequestMapper? _instance;
  static RescheduleAppointmentRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = RescheduleAppointmentRequestMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'RescheduleAppointmentRequest';

  static String _$appointmentDate(RescheduleAppointmentRequest v) =>
      v.appointmentDate;
  static const Field<RescheduleAppointmentRequest, String> _f$appointmentDate =
      Field('appointmentDate', _$appointmentDate, key: r'appointment_date');
  static int _$startMinutes(RescheduleAppointmentRequest v) => v.startMinutes;
  static const Field<RescheduleAppointmentRequest, int> _f$startMinutes = Field(
    'startMinutes',
    _$startMinutes,
    key: r'start_minutes',
  );

  @override
  final MappableFields<RescheduleAppointmentRequest> fields = const {
    #appointmentDate: _f$appointmentDate,
    #startMinutes: _f$startMinutes,
  };

  static RescheduleAppointmentRequest _instantiate(DecodingData data) {
    return RescheduleAppointmentRequest(
      appointmentDate: data.dec(_f$appointmentDate),
      startMinutes: data.dec(_f$startMinutes),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RescheduleAppointmentRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RescheduleAppointmentRequest>(map);
  }

  static RescheduleAppointmentRequest fromJson(String json) {
    return ensureInitialized().decodeJson<RescheduleAppointmentRequest>(json);
  }
}

mixin RescheduleAppointmentRequestMappable {
  String toJson() {
    return RescheduleAppointmentRequestMapper.ensureInitialized()
        .encodeJson<RescheduleAppointmentRequest>(
          this as RescheduleAppointmentRequest,
        );
  }

  Map<String, dynamic> toMap() {
    return RescheduleAppointmentRequestMapper.ensureInitialized()
        .encodeMap<RescheduleAppointmentRequest>(
          this as RescheduleAppointmentRequest,
        );
  }

  RescheduleAppointmentRequestCopyWith<
    RescheduleAppointmentRequest,
    RescheduleAppointmentRequest,
    RescheduleAppointmentRequest
  >
  get copyWith =>
      _RescheduleAppointmentRequestCopyWithImpl<
        RescheduleAppointmentRequest,
        RescheduleAppointmentRequest
      >(this as RescheduleAppointmentRequest, $identity, $identity);
  @override
  String toString() {
    return RescheduleAppointmentRequestMapper.ensureInitialized()
        .stringifyValue(this as RescheduleAppointmentRequest);
  }

  @override
  bool operator ==(Object other) {
    return RescheduleAppointmentRequestMapper.ensureInitialized().equalsValue(
      this as RescheduleAppointmentRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return RescheduleAppointmentRequestMapper.ensureInitialized().hashValue(
      this as RescheduleAppointmentRequest,
    );
  }
}

extension RescheduleAppointmentRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RescheduleAppointmentRequest, $Out> {
  RescheduleAppointmentRequestCopyWith<$R, RescheduleAppointmentRequest, $Out>
  get $asRescheduleAppointmentRequest => $base.as(
    (v, t, t2) => _RescheduleAppointmentRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class RescheduleAppointmentRequestCopyWith<
  $R,
  $In extends RescheduleAppointmentRequest,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? appointmentDate, int? startMinutes});
  RescheduleAppointmentRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RescheduleAppointmentRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RescheduleAppointmentRequest, $Out>
    implements
        RescheduleAppointmentRequestCopyWith<
          $R,
          RescheduleAppointmentRequest,
          $Out
        > {
  _RescheduleAppointmentRequestCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<RescheduleAppointmentRequest> $mapper =
      RescheduleAppointmentRequestMapper.ensureInitialized();
  @override
  $R call({String? appointmentDate, int? startMinutes}) => $apply(
    FieldCopyWithData({
      if (appointmentDate != null) #appointmentDate: appointmentDate,
      if (startMinutes != null) #startMinutes: startMinutes,
    }),
  );
  @override
  RescheduleAppointmentRequest $make(CopyWithData data) =>
      RescheduleAppointmentRequest(
        appointmentDate: data.get(#appointmentDate, or: $value.appointmentDate),
        startMinutes: data.get(#startMinutes, or: $value.startMinutes),
      );

  @override
  RescheduleAppointmentRequestCopyWith<$R2, RescheduleAppointmentRequest, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _RescheduleAppointmentRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

