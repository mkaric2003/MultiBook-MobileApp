// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'update_appointment_status_request.dart';

class UpdateAppointmentStatusRequestMapper
    extends ClassMapperBase<UpdateAppointmentStatusRequest> {
  UpdateAppointmentStatusRequestMapper._();

  static UpdateAppointmentStatusRequestMapper? _instance;
  static UpdateAppointmentStatusRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = UpdateAppointmentStatusRequestMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'UpdateAppointmentStatusRequest';

  static String _$status(UpdateAppointmentStatusRequest v) => v.status;
  static const Field<UpdateAppointmentStatusRequest, String> _f$status = Field(
    'status',
    _$status,
  );

  @override
  final MappableFields<UpdateAppointmentStatusRequest> fields = const {
    #status: _f$status,
  };

  static UpdateAppointmentStatusRequest _instantiate(DecodingData data) {
    return UpdateAppointmentStatusRequest(status: data.dec(_f$status));
  }

  @override
  final Function instantiate = _instantiate;

  static UpdateAppointmentStatusRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UpdateAppointmentStatusRequest>(map);
  }

  static UpdateAppointmentStatusRequest fromJson(String json) {
    return ensureInitialized().decodeJson<UpdateAppointmentStatusRequest>(json);
  }
}

mixin UpdateAppointmentStatusRequestMappable {
  String toJson() {
    return UpdateAppointmentStatusRequestMapper.ensureInitialized()
        .encodeJson<UpdateAppointmentStatusRequest>(
          this as UpdateAppointmentStatusRequest,
        );
  }

  Map<String, dynamic> toMap() {
    return UpdateAppointmentStatusRequestMapper.ensureInitialized()
        .encodeMap<UpdateAppointmentStatusRequest>(
          this as UpdateAppointmentStatusRequest,
        );
  }

  UpdateAppointmentStatusRequestCopyWith<
    UpdateAppointmentStatusRequest,
    UpdateAppointmentStatusRequest,
    UpdateAppointmentStatusRequest
  >
  get copyWith =>
      _UpdateAppointmentStatusRequestCopyWithImpl<
        UpdateAppointmentStatusRequest,
        UpdateAppointmentStatusRequest
      >(this as UpdateAppointmentStatusRequest, $identity, $identity);
  @override
  String toString() {
    return UpdateAppointmentStatusRequestMapper.ensureInitialized()
        .stringifyValue(this as UpdateAppointmentStatusRequest);
  }

  @override
  bool operator ==(Object other) {
    return UpdateAppointmentStatusRequestMapper.ensureInitialized().equalsValue(
      this as UpdateAppointmentStatusRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return UpdateAppointmentStatusRequestMapper.ensureInitialized().hashValue(
      this as UpdateAppointmentStatusRequest,
    );
  }
}

extension UpdateAppointmentStatusRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UpdateAppointmentStatusRequest, $Out> {
  UpdateAppointmentStatusRequestCopyWith<
    $R,
    UpdateAppointmentStatusRequest,
    $Out
  >
  get $asUpdateAppointmentStatusRequest => $base.as(
    (v, t, t2) =>
        _UpdateAppointmentStatusRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class UpdateAppointmentStatusRequestCopyWith<
  $R,
  $In extends UpdateAppointmentStatusRequest,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? status});
  UpdateAppointmentStatusRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _UpdateAppointmentStatusRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UpdateAppointmentStatusRequest, $Out>
    implements
        UpdateAppointmentStatusRequestCopyWith<
          $R,
          UpdateAppointmentStatusRequest,
          $Out
        > {
  _UpdateAppointmentStatusRequestCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<UpdateAppointmentStatusRequest> $mapper =
      UpdateAppointmentStatusRequestMapper.ensureInitialized();
  @override
  $R call({String? status}) =>
      $apply(FieldCopyWithData({if (status != null) #status: status}));
  @override
  UpdateAppointmentStatusRequest $make(CopyWithData data) =>
      UpdateAppointmentStatusRequest(
        status: data.get(#status, or: $value.status),
      );

  @override
  UpdateAppointmentStatusRequestCopyWith<
    $R2,
    UpdateAppointmentStatusRequest,
    $Out2
  >
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _UpdateAppointmentStatusRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

