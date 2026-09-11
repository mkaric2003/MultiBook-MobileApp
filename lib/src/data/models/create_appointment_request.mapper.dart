// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'create_appointment_request.dart';

class CreateAppointmentRequestMapper
    extends ClassMapperBase<CreateAppointmentRequest> {
  CreateAppointmentRequestMapper._();

  static CreateAppointmentRequestMapper? _instance;
  static CreateAppointmentRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = CreateAppointmentRequestMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'CreateAppointmentRequest';

  static String _$staffId(CreateAppointmentRequest v) => v.staffId;
  static const Field<CreateAppointmentRequest, String> _f$staffId = Field(
    'staffId',
    _$staffId,
    key: r'staff_id',
  );
  static String _$appointmentDate(CreateAppointmentRequest v) =>
      v.appointmentDate;
  static const Field<CreateAppointmentRequest, String> _f$appointmentDate =
      Field('appointmentDate', _$appointmentDate, key: r'appointment_date');
  static int _$startMinutes(CreateAppointmentRequest v) => v.startMinutes;
  static const Field<CreateAppointmentRequest, int> _f$startMinutes = Field(
    'startMinutes',
    _$startMinutes,
    key: r'start_minutes',
  );
  static List<String> _$offeringIds(CreateAppointmentRequest v) =>
      v.offeringIds;
  static const Field<CreateAppointmentRequest, List<String>> _f$offeringIds =
      Field('offeringIds', _$offeringIds, key: r'offering_ids');
  static String _$customerName(CreateAppointmentRequest v) => v.customerName;
  static const Field<CreateAppointmentRequest, String> _f$customerName = Field(
    'customerName',
    _$customerName,
    key: r'customer_name',
  );
  static String _$customerEmail(CreateAppointmentRequest v) => v.customerEmail;
  static const Field<CreateAppointmentRequest, String> _f$customerEmail = Field(
    'customerEmail',
    _$customerEmail,
    key: r'customer_email',
  );
  static String _$customerPhone(CreateAppointmentRequest v) => v.customerPhone;
  static const Field<CreateAppointmentRequest, String> _f$customerPhone = Field(
    'customerPhone',
    _$customerPhone,
    key: r'customer_phone',
  );
  static String _$paymentMethod(CreateAppointmentRequest v) => v.paymentMethod;
  static const Field<CreateAppointmentRequest, String> _f$paymentMethod = Field(
    'paymentMethod',
    _$paymentMethod,
    key: r'payment_method',
  );
  static String? _$promoCode(CreateAppointmentRequest v) => v.promoCode;
  static const Field<CreateAppointmentRequest, String> _f$promoCode = Field(
    'promoCode',
    _$promoCode,
    key: r'promo_code',
    opt: true,
  );

  @override
  final MappableFields<CreateAppointmentRequest> fields = const {
    #staffId: _f$staffId,
    #appointmentDate: _f$appointmentDate,
    #startMinutes: _f$startMinutes,
    #offeringIds: _f$offeringIds,
    #customerName: _f$customerName,
    #customerEmail: _f$customerEmail,
    #customerPhone: _f$customerPhone,
    #paymentMethod: _f$paymentMethod,
    #promoCode: _f$promoCode,
  };

  static CreateAppointmentRequest _instantiate(DecodingData data) {
    return CreateAppointmentRequest(
      staffId: data.dec(_f$staffId),
      appointmentDate: data.dec(_f$appointmentDate),
      startMinutes: data.dec(_f$startMinutes),
      offeringIds: data.dec(_f$offeringIds),
      customerName: data.dec(_f$customerName),
      customerEmail: data.dec(_f$customerEmail),
      customerPhone: data.dec(_f$customerPhone),
      paymentMethod: data.dec(_f$paymentMethod),
      promoCode: data.dec(_f$promoCode),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CreateAppointmentRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CreateAppointmentRequest>(map);
  }

  static CreateAppointmentRequest fromJson(String json) {
    return ensureInitialized().decodeJson<CreateAppointmentRequest>(json);
  }
}

mixin CreateAppointmentRequestMappable {
  String toJson() {
    return CreateAppointmentRequestMapper.ensureInitialized()
        .encodeJson<CreateAppointmentRequest>(this as CreateAppointmentRequest);
  }

  Map<String, dynamic> toMap() {
    return CreateAppointmentRequestMapper.ensureInitialized()
        .encodeMap<CreateAppointmentRequest>(this as CreateAppointmentRequest);
  }

  CreateAppointmentRequestCopyWith<
    CreateAppointmentRequest,
    CreateAppointmentRequest,
    CreateAppointmentRequest
  >
  get copyWith =>
      _CreateAppointmentRequestCopyWithImpl<
        CreateAppointmentRequest,
        CreateAppointmentRequest
      >(this as CreateAppointmentRequest, $identity, $identity);
  @override
  String toString() {
    return CreateAppointmentRequestMapper.ensureInitialized().stringifyValue(
      this as CreateAppointmentRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return CreateAppointmentRequestMapper.ensureInitialized().equalsValue(
      this as CreateAppointmentRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return CreateAppointmentRequestMapper.ensureInitialized().hashValue(
      this as CreateAppointmentRequest,
    );
  }
}

extension CreateAppointmentRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CreateAppointmentRequest, $Out> {
  CreateAppointmentRequestCopyWith<$R, CreateAppointmentRequest, $Out>
  get $asCreateAppointmentRequest => $base.as(
    (v, t, t2) => _CreateAppointmentRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CreateAppointmentRequestCopyWith<
  $R,
  $In extends CreateAppointmentRequest,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get offeringIds;
  $R call({
    String? staffId,
    String? appointmentDate,
    int? startMinutes,
    List<String>? offeringIds,
    String? customerName,
    String? customerEmail,
    String? customerPhone,
    String? paymentMethod,
    String? promoCode,
  });
  CreateAppointmentRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CreateAppointmentRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CreateAppointmentRequest, $Out>
    implements
        CreateAppointmentRequestCopyWith<$R, CreateAppointmentRequest, $Out> {
  _CreateAppointmentRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CreateAppointmentRequest> $mapper =
      CreateAppointmentRequestMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get offeringIds => ListCopyWith(
    $value.offeringIds,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(offeringIds: v),
  );
  @override
  $R call({
    String? staffId,
    String? appointmentDate,
    int? startMinutes,
    List<String>? offeringIds,
    String? customerName,
    String? customerEmail,
    String? customerPhone,
    String? paymentMethod,
    Object? promoCode = $none,
  }) => $apply(
    FieldCopyWithData({
      if (staffId != null) #staffId: staffId,
      if (appointmentDate != null) #appointmentDate: appointmentDate,
      if (startMinutes != null) #startMinutes: startMinutes,
      if (offeringIds != null) #offeringIds: offeringIds,
      if (customerName != null) #customerName: customerName,
      if (customerEmail != null) #customerEmail: customerEmail,
      if (customerPhone != null) #customerPhone: customerPhone,
      if (paymentMethod != null) #paymentMethod: paymentMethod,
      if (promoCode != $none) #promoCode: promoCode,
    }),
  );
  @override
  CreateAppointmentRequest $make(CopyWithData data) => CreateAppointmentRequest(
    staffId: data.get(#staffId, or: $value.staffId),
    appointmentDate: data.get(#appointmentDate, or: $value.appointmentDate),
    startMinutes: data.get(#startMinutes, or: $value.startMinutes),
    offeringIds: data.get(#offeringIds, or: $value.offeringIds),
    customerName: data.get(#customerName, or: $value.customerName),
    customerEmail: data.get(#customerEmail, or: $value.customerEmail),
    customerPhone: data.get(#customerPhone, or: $value.customerPhone),
    paymentMethod: data.get(#paymentMethod, or: $value.paymentMethod),
    promoCode: data.get(#promoCode, or: $value.promoCode),
  );

  @override
  CreateAppointmentRequestCopyWith<$R2, CreateAppointmentRequest, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CreateAppointmentRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

