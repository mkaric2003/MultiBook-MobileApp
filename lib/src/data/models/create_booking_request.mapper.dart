// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'create_booking_request.dart';

class CreateBookingRequestMapper extends ClassMapperBase<CreateBookingRequest> {
  CreateBookingRequestMapper._();

  static CreateBookingRequestMapper? _instance;
  static CreateBookingRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CreateBookingRequestMapper._());
      BookingExtraRequestMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CreateBookingRequest';

  static String? _$stayUnitTypeId(CreateBookingRequest v) => v.stayUnitTypeId;
  static const Field<CreateBookingRequest, String> _f$stayUnitTypeId = Field(
    'stayUnitTypeId',
    _$stayUnitTypeId,
    opt: true,
  );
  static String _$checkIn(CreateBookingRequest v) => v.checkIn;
  static const Field<CreateBookingRequest, String> _f$checkIn = Field(
    'checkIn',
    _$checkIn,
  );
  static String _$checkOut(CreateBookingRequest v) => v.checkOut;
  static const Field<CreateBookingRequest, String> _f$checkOut = Field(
    'checkOut',
    _$checkOut,
  );
  static int _$adults(CreateBookingRequest v) => v.adults;
  static const Field<CreateBookingRequest, int> _f$adults = Field(
    'adults',
    _$adults,
  );
  static int _$children(CreateBookingRequest v) => v.children;
  static const Field<CreateBookingRequest, int> _f$children = Field(
    'children',
    _$children,
  );
  static int _$infants(CreateBookingRequest v) => v.infants;
  static const Field<CreateBookingRequest, int> _f$infants = Field(
    'infants',
    _$infants,
  );
  static List<BookingExtraRequest> _$selectedExtras(CreateBookingRequest v) =>
      v.selectedExtras;
  static const Field<CreateBookingRequest, List<BookingExtraRequest>>
  _f$selectedExtras = Field('selectedExtras', _$selectedExtras);
  static String _$customerName(CreateBookingRequest v) => v.customerName;
  static const Field<CreateBookingRequest, String> _f$customerName = Field(
    'customerName',
    _$customerName,
  );
  static String _$customerEmail(CreateBookingRequest v) => v.customerEmail;
  static const Field<CreateBookingRequest, String> _f$customerEmail = Field(
    'customerEmail',
    _$customerEmail,
  );
  static String _$paymentMethod(CreateBookingRequest v) => v.paymentMethod;
  static const Field<CreateBookingRequest, String> _f$paymentMethod = Field(
    'paymentMethod',
    _$paymentMethod,
  );

  @override
  final MappableFields<CreateBookingRequest> fields = const {
    #stayUnitTypeId: _f$stayUnitTypeId,
    #checkIn: _f$checkIn,
    #checkOut: _f$checkOut,
    #adults: _f$adults,
    #children: _f$children,
    #infants: _f$infants,
    #selectedExtras: _f$selectedExtras,
    #customerName: _f$customerName,
    #customerEmail: _f$customerEmail,
    #paymentMethod: _f$paymentMethod,
  };

  static CreateBookingRequest _instantiate(DecodingData data) {
    return CreateBookingRequest(
      stayUnitTypeId: data.dec(_f$stayUnitTypeId),
      checkIn: data.dec(_f$checkIn),
      checkOut: data.dec(_f$checkOut),
      adults: data.dec(_f$adults),
      children: data.dec(_f$children),
      infants: data.dec(_f$infants),
      selectedExtras: data.dec(_f$selectedExtras),
      customerName: data.dec(_f$customerName),
      customerEmail: data.dec(_f$customerEmail),
      paymentMethod: data.dec(_f$paymentMethod),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CreateBookingRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CreateBookingRequest>(map);
  }

  static CreateBookingRequest fromJson(String json) {
    return ensureInitialized().decodeJson<CreateBookingRequest>(json);
  }
}

mixin CreateBookingRequestMappable {
  String toJson() {
    return CreateBookingRequestMapper.ensureInitialized()
        .encodeJson<CreateBookingRequest>(this as CreateBookingRequest);
  }

  Map<String, dynamic> toMap() {
    return CreateBookingRequestMapper.ensureInitialized()
        .encodeMap<CreateBookingRequest>(this as CreateBookingRequest);
  }

  CreateBookingRequestCopyWith<
    CreateBookingRequest,
    CreateBookingRequest,
    CreateBookingRequest
  >
  get copyWith =>
      _CreateBookingRequestCopyWithImpl<
        CreateBookingRequest,
        CreateBookingRequest
      >(this as CreateBookingRequest, $identity, $identity);
  @override
  String toString() {
    return CreateBookingRequestMapper.ensureInitialized().stringifyValue(
      this as CreateBookingRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return CreateBookingRequestMapper.ensureInitialized().equalsValue(
      this as CreateBookingRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return CreateBookingRequestMapper.ensureInitialized().hashValue(
      this as CreateBookingRequest,
    );
  }
}

extension CreateBookingRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CreateBookingRequest, $Out> {
  CreateBookingRequestCopyWith<$R, CreateBookingRequest, $Out>
  get $asCreateBookingRequest => $base.as(
    (v, t, t2) => _CreateBookingRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CreateBookingRequestCopyWith<
  $R,
  $In extends CreateBookingRequest,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    BookingExtraRequest,
    BookingExtraRequestCopyWith<$R, BookingExtraRequest, BookingExtraRequest>
  >
  get selectedExtras;
  $R call({
    String? stayUnitTypeId,
    String? checkIn,
    String? checkOut,
    int? adults,
    int? children,
    int? infants,
    List<BookingExtraRequest>? selectedExtras,
    String? customerName,
    String? customerEmail,
    String? paymentMethod,
  });
  CreateBookingRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CreateBookingRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CreateBookingRequest, $Out>
    implements CreateBookingRequestCopyWith<$R, CreateBookingRequest, $Out> {
  _CreateBookingRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CreateBookingRequest> $mapper =
      CreateBookingRequestMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    BookingExtraRequest,
    BookingExtraRequestCopyWith<$R, BookingExtraRequest, BookingExtraRequest>
  >
  get selectedExtras => ListCopyWith(
    $value.selectedExtras,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(selectedExtras: v),
  );
  @override
  $R call({
    Object? stayUnitTypeId = $none,
    String? checkIn,
    String? checkOut,
    int? adults,
    int? children,
    int? infants,
    List<BookingExtraRequest>? selectedExtras,
    String? customerName,
    String? customerEmail,
    String? paymentMethod,
  }) => $apply(
    FieldCopyWithData({
      if (stayUnitTypeId != $none) #stayUnitTypeId: stayUnitTypeId,
      if (checkIn != null) #checkIn: checkIn,
      if (checkOut != null) #checkOut: checkOut,
      if (adults != null) #adults: adults,
      if (children != null) #children: children,
      if (infants != null) #infants: infants,
      if (selectedExtras != null) #selectedExtras: selectedExtras,
      if (customerName != null) #customerName: customerName,
      if (customerEmail != null) #customerEmail: customerEmail,
      if (paymentMethod != null) #paymentMethod: paymentMethod,
    }),
  );
  @override
  CreateBookingRequest $make(CopyWithData data) => CreateBookingRequest(
    stayUnitTypeId: data.get(#stayUnitTypeId, or: $value.stayUnitTypeId),
    checkIn: data.get(#checkIn, or: $value.checkIn),
    checkOut: data.get(#checkOut, or: $value.checkOut),
    adults: data.get(#adults, or: $value.adults),
    children: data.get(#children, or: $value.children),
    infants: data.get(#infants, or: $value.infants),
    selectedExtras: data.get(#selectedExtras, or: $value.selectedExtras),
    customerName: data.get(#customerName, or: $value.customerName),
    customerEmail: data.get(#customerEmail, or: $value.customerEmail),
    paymentMethod: data.get(#paymentMethod, or: $value.paymentMethod),
  );

  @override
  CreateBookingRequestCopyWith<$R2, CreateBookingRequest, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CreateBookingRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

