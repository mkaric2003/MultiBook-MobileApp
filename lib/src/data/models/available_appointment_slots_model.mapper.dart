// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'available_appointment_slots_model.dart';

class AvailableAppointmentSlotsModelMapper
    extends ClassMapperBase<AvailableAppointmentSlotsModel> {
  AvailableAppointmentSlotsModelMapper._();

  static AvailableAppointmentSlotsModelMapper? _instance;
  static AvailableAppointmentSlotsModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = AvailableAppointmentSlotsModelMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'AvailableAppointmentSlotsModel';

  static String _$staffId(AvailableAppointmentSlotsModel v) => v.staffId;
  static const Field<AvailableAppointmentSlotsModel, String> _f$staffId = Field(
    'staffId',
    _$staffId,
    key: r'staff_id',
  );
  static String _$appointmentDate(AvailableAppointmentSlotsModel v) =>
      v.appointmentDate;
  static const Field<AvailableAppointmentSlotsModel, String>
  _f$appointmentDate = Field(
    'appointmentDate',
    _$appointmentDate,
    key: r'appointment_date',
  );
  static int _$durationMinutes(AvailableAppointmentSlotsModel v) =>
      v.durationMinutes;
  static const Field<AvailableAppointmentSlotsModel, int> _f$durationMinutes =
      Field('durationMinutes', _$durationMinutes, key: r'duration_minutes');
  static List<int> _$startMinutes(AvailableAppointmentSlotsModel v) =>
      v.startMinutes;
  static const Field<AvailableAppointmentSlotsModel, List<int>>
  _f$startMinutes = Field(
    'startMinutes',
    _$startMinutes,
    key: r'start_minutes',
  );

  @override
  final MappableFields<AvailableAppointmentSlotsModel> fields = const {
    #staffId: _f$staffId,
    #appointmentDate: _f$appointmentDate,
    #durationMinutes: _f$durationMinutes,
    #startMinutes: _f$startMinutes,
  };

  static AvailableAppointmentSlotsModel _instantiate(DecodingData data) {
    return AvailableAppointmentSlotsModel(
      staffId: data.dec(_f$staffId),
      appointmentDate: data.dec(_f$appointmentDate),
      durationMinutes: data.dec(_f$durationMinutes),
      startMinutes: data.dec(_f$startMinutes),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AvailableAppointmentSlotsModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AvailableAppointmentSlotsModel>(map);
  }

  static AvailableAppointmentSlotsModel fromJson(String json) {
    return ensureInitialized().decodeJson<AvailableAppointmentSlotsModel>(json);
  }
}

mixin AvailableAppointmentSlotsModelMappable {
  String toJson() {
    return AvailableAppointmentSlotsModelMapper.ensureInitialized()
        .encodeJson<AvailableAppointmentSlotsModel>(
          this as AvailableAppointmentSlotsModel,
        );
  }

  Map<String, dynamic> toMap() {
    return AvailableAppointmentSlotsModelMapper.ensureInitialized()
        .encodeMap<AvailableAppointmentSlotsModel>(
          this as AvailableAppointmentSlotsModel,
        );
  }

  AvailableAppointmentSlotsModelCopyWith<
    AvailableAppointmentSlotsModel,
    AvailableAppointmentSlotsModel,
    AvailableAppointmentSlotsModel
  >
  get copyWith =>
      _AvailableAppointmentSlotsModelCopyWithImpl<
        AvailableAppointmentSlotsModel,
        AvailableAppointmentSlotsModel
      >(this as AvailableAppointmentSlotsModel, $identity, $identity);
  @override
  String toString() {
    return AvailableAppointmentSlotsModelMapper.ensureInitialized()
        .stringifyValue(this as AvailableAppointmentSlotsModel);
  }

  @override
  bool operator ==(Object other) {
    return AvailableAppointmentSlotsModelMapper.ensureInitialized().equalsValue(
      this as AvailableAppointmentSlotsModel,
      other,
    );
  }

  @override
  int get hashCode {
    return AvailableAppointmentSlotsModelMapper.ensureInitialized().hashValue(
      this as AvailableAppointmentSlotsModel,
    );
  }
}

extension AvailableAppointmentSlotsModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AvailableAppointmentSlotsModel, $Out> {
  AvailableAppointmentSlotsModelCopyWith<
    $R,
    AvailableAppointmentSlotsModel,
    $Out
  >
  get $asAvailableAppointmentSlotsModel => $base.as(
    (v, t, t2) =>
        _AvailableAppointmentSlotsModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AvailableAppointmentSlotsModelCopyWith<
  $R,
  $In extends AvailableAppointmentSlotsModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get startMinutes;
  $R call({
    String? staffId,
    String? appointmentDate,
    int? durationMinutes,
    List<int>? startMinutes,
  });
  AvailableAppointmentSlotsModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AvailableAppointmentSlotsModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AvailableAppointmentSlotsModel, $Out>
    implements
        AvailableAppointmentSlotsModelCopyWith<
          $R,
          AvailableAppointmentSlotsModel,
          $Out
        > {
  _AvailableAppointmentSlotsModelCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<AvailableAppointmentSlotsModel> $mapper =
      AvailableAppointmentSlotsModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get startMinutes =>
      ListCopyWith(
        $value.startMinutes,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(startMinutes: v),
      );
  @override
  $R call({
    String? staffId,
    String? appointmentDate,
    int? durationMinutes,
    List<int>? startMinutes,
  }) => $apply(
    FieldCopyWithData({
      if (staffId != null) #staffId: staffId,
      if (appointmentDate != null) #appointmentDate: appointmentDate,
      if (durationMinutes != null) #durationMinutes: durationMinutes,
      if (startMinutes != null) #startMinutes: startMinutes,
    }),
  );
  @override
  AvailableAppointmentSlotsModel $make(CopyWithData data) =>
      AvailableAppointmentSlotsModel(
        staffId: data.get(#staffId, or: $value.staffId),
        appointmentDate: data.get(#appointmentDate, or: $value.appointmentDate),
        durationMinutes: data.get(#durationMinutes, or: $value.durationMinutes),
        startMinutes: data.get(#startMinutes, or: $value.startMinutes),
      );

  @override
  AvailableAppointmentSlotsModelCopyWith<
    $R2,
    AvailableAppointmentSlotsModel,
    $Out2
  >
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AvailableAppointmentSlotsModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

