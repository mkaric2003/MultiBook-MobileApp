// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'booking_model.dart';

class BookingModelMapper extends ClassMapperBase<BookingModel> {
  BookingModelMapper._();

  static BookingModelMapper? _instance;
  static BookingModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BookingModelMapper._());
      StayExtraModelMapper.ensureInitialized();
      BookingStatusMapper.ensureInitialized();
      PaymentStatusMapper.ensureInitialized();
      CurrencyCodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BookingModel';

  static String _$id(BookingModel v) => v.id;
  static const Field<BookingModel, String> _f$id = Field('id', _$id);
  static String _$businessId(BookingModel v) => v.businessId;
  static const Field<BookingModel, String> _f$businessId = Field(
    'businessId',
    _$businessId,
  );
  static String _$businessOwnerId(BookingModel v) => v.businessOwnerId;
  static const Field<BookingModel, String> _f$businessOwnerId = Field(
    'businessOwnerId',
    _$businessOwnerId,
  );
  static String _$customerId(BookingModel v) => v.customerId;
  static const Field<BookingModel, String> _f$customerId = Field(
    'customerId',
    _$customerId,
  );
  static String _$customerName(BookingModel v) => v.customerName;
  static const Field<BookingModel, String> _f$customerName = Field(
    'customerName',
    _$customerName,
  );
  static String _$customerEmail(BookingModel v) => v.customerEmail;
  static const Field<BookingModel, String> _f$customerEmail = Field(
    'customerEmail',
    _$customerEmail,
  );
  static String _$businessName(BookingModel v) => v.businessName;
  static const Field<BookingModel, String> _f$businessName = Field(
    'businessName',
    _$businessName,
  );
  static String _$businessCity(BookingModel v) => v.businessCity;
  static const Field<BookingModel, String> _f$businessCity = Field(
    'businessCity',
    _$businessCity,
  );
  static String _$businessImageUrl(BookingModel v) => v.businessImageUrl;
  static const Field<BookingModel, String> _f$businessImageUrl = Field(
    'businessImageUrl',
    _$businessImageUrl,
  );
  static DateTime _$checkIn(BookingModel v) => v.checkIn;
  static const Field<BookingModel, DateTime> _f$checkIn = Field(
    'checkIn',
    _$checkIn,
  );
  static DateTime _$checkOut(BookingModel v) => v.checkOut;
  static const Field<BookingModel, DateTime> _f$checkOut = Field(
    'checkOut',
    _$checkOut,
  );
  static int _$adults(BookingModel v) => v.adults;
  static const Field<BookingModel, int> _f$adults = Field('adults', _$adults);
  static int _$children(BookingModel v) => v.children;
  static const Field<BookingModel, int> _f$children = Field(
    'children',
    _$children,
  );
  static int _$infants(BookingModel v) => v.infants;
  static const Field<BookingModel, int> _f$infants = Field(
    'infants',
    _$infants,
  );
  static int _$pricePerNight(BookingModel v) => v.pricePerNight;
  static const Field<BookingModel, int> _f$pricePerNight = Field(
    'pricePerNight',
    _$pricePerNight,
  );
  static List<StayExtraModel> _$selectedExtras(BookingModel v) =>
      v.selectedExtras;
  static const Field<BookingModel, List<StayExtraModel>> _f$selectedExtras =
      Field('selectedExtras', _$selectedExtras);
  static int _$roomSubtotal(BookingModel v) => v.roomSubtotal;
  static const Field<BookingModel, int> _f$roomSubtotal = Field(
    'roomSubtotal',
    _$roomSubtotal,
  );
  static int _$discountAmount(BookingModel v) => v.discountAmount;
  static const Field<BookingModel, int> _f$discountAmount = Field(
    'discountAmount',
    _$discountAmount,
    opt: true,
    def: 0,
  );
  static int _$cleaningFee(BookingModel v) => v.cleaningFee;
  static const Field<BookingModel, int> _f$cleaningFee = Field(
    'cleaningFee',
    _$cleaningFee,
  );
  static int _$serviceFee(BookingModel v) => v.serviceFee;
  static const Field<BookingModel, int> _f$serviceFee = Field(
    'serviceFee',
    _$serviceFee,
  );
  static int _$taxes(BookingModel v) => v.taxes;
  static const Field<BookingModel, int> _f$taxes = Field('taxes', _$taxes);
  static int _$total(BookingModel v) => v.total;
  static const Field<BookingModel, int> _f$total = Field('total', _$total);
  static int _$originalTotal(BookingModel v) => v.originalTotal;
  static const Field<BookingModel, int> _f$originalTotal = Field(
    'originalTotal',
    _$originalTotal,
    opt: true,
    def: 0,
  );
  static BookingStatus _$status(BookingModel v) => v.status;
  static const Field<BookingModel, BookingStatus> _f$status = Field(
    'status',
    _$status,
  );
  static PaymentStatus _$paymentStatus(BookingModel v) => v.paymentStatus;
  static const Field<BookingModel, PaymentStatus> _f$paymentStatus = Field(
    'paymentStatus',
    _$paymentStatus,
  );
  static String _$paymentMethod(BookingModel v) => v.paymentMethod;
  static const Field<BookingModel, String> _f$paymentMethod = Field(
    'paymentMethod',
    _$paymentMethod,
  );
  static String _$confirmationCode(BookingModel v) => v.confirmationCode;
  static const Field<BookingModel, String> _f$confirmationCode = Field(
    'confirmationCode',
    _$confirmationCode,
  );
  static CurrencyCode _$currency(BookingModel v) => v.currency;
  static const Field<BookingModel, CurrencyCode> _f$currency = Field(
    'currency',
    _$currency,
    opt: true,
    def: CurrencyCode.bam,
  );
  static String? _$roomType(BookingModel v) => v.roomType;
  static const Field<BookingModel, String> _f$roomType = Field(
    'roomType',
    _$roomType,
    opt: true,
  );
  static String? _$roomTypeId(BookingModel v) => v.roomTypeId;
  static const Field<BookingModel, String> _f$roomTypeId = Field(
    'roomTypeId',
    _$roomTypeId,
    opt: true,
  );
  static String? _$customerAvatarUrl(BookingModel v) => v.customerAvatarUrl;
  static const Field<BookingModel, String> _f$customerAvatarUrl = Field(
    'customerAvatarUrl',
    _$customerAvatarUrl,
    opt: true,
  );
  static DateTime? _$createdAt(BookingModel v) => v.createdAt;
  static const Field<BookingModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );

  @override
  final MappableFields<BookingModel> fields = const {
    #id: _f$id,
    #businessId: _f$businessId,
    #businessOwnerId: _f$businessOwnerId,
    #customerId: _f$customerId,
    #customerName: _f$customerName,
    #customerEmail: _f$customerEmail,
    #businessName: _f$businessName,
    #businessCity: _f$businessCity,
    #businessImageUrl: _f$businessImageUrl,
    #checkIn: _f$checkIn,
    #checkOut: _f$checkOut,
    #adults: _f$adults,
    #children: _f$children,
    #infants: _f$infants,
    #pricePerNight: _f$pricePerNight,
    #selectedExtras: _f$selectedExtras,
    #roomSubtotal: _f$roomSubtotal,
    #discountAmount: _f$discountAmount,
    #cleaningFee: _f$cleaningFee,
    #serviceFee: _f$serviceFee,
    #taxes: _f$taxes,
    #total: _f$total,
    #originalTotal: _f$originalTotal,
    #status: _f$status,
    #paymentStatus: _f$paymentStatus,
    #paymentMethod: _f$paymentMethod,
    #confirmationCode: _f$confirmationCode,
    #currency: _f$currency,
    #roomType: _f$roomType,
    #roomTypeId: _f$roomTypeId,
    #customerAvatarUrl: _f$customerAvatarUrl,
    #createdAt: _f$createdAt,
  };

  static BookingModel _instantiate(DecodingData data) {
    return BookingModel(
      id: data.dec(_f$id),
      businessId: data.dec(_f$businessId),
      businessOwnerId: data.dec(_f$businessOwnerId),
      customerId: data.dec(_f$customerId),
      customerName: data.dec(_f$customerName),
      customerEmail: data.dec(_f$customerEmail),
      businessName: data.dec(_f$businessName),
      businessCity: data.dec(_f$businessCity),
      businessImageUrl: data.dec(_f$businessImageUrl),
      checkIn: data.dec(_f$checkIn),
      checkOut: data.dec(_f$checkOut),
      adults: data.dec(_f$adults),
      children: data.dec(_f$children),
      infants: data.dec(_f$infants),
      pricePerNight: data.dec(_f$pricePerNight),
      selectedExtras: data.dec(_f$selectedExtras),
      roomSubtotal: data.dec(_f$roomSubtotal),
      discountAmount: data.dec(_f$discountAmount),
      cleaningFee: data.dec(_f$cleaningFee),
      serviceFee: data.dec(_f$serviceFee),
      taxes: data.dec(_f$taxes),
      total: data.dec(_f$total),
      originalTotal: data.dec(_f$originalTotal),
      status: data.dec(_f$status),
      paymentStatus: data.dec(_f$paymentStatus),
      paymentMethod: data.dec(_f$paymentMethod),
      confirmationCode: data.dec(_f$confirmationCode),
      currency: data.dec(_f$currency),
      roomType: data.dec(_f$roomType),
      roomTypeId: data.dec(_f$roomTypeId),
      customerAvatarUrl: data.dec(_f$customerAvatarUrl),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static BookingModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BookingModel>(map);
  }

  static BookingModel fromJson(String json) {
    return ensureInitialized().decodeJson<BookingModel>(json);
  }
}

mixin BookingModelMappable {
  String toJson() {
    return BookingModelMapper.ensureInitialized().encodeJson<BookingModel>(
      this as BookingModel,
    );
  }

  Map<String, dynamic> toMap() {
    return BookingModelMapper.ensureInitialized().encodeMap<BookingModel>(
      this as BookingModel,
    );
  }

  BookingModelCopyWith<BookingModel, BookingModel, BookingModel> get copyWith =>
      _BookingModelCopyWithImpl<BookingModel, BookingModel>(
        this as BookingModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return BookingModelMapper.ensureInitialized().stringifyValue(
      this as BookingModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return BookingModelMapper.ensureInitialized().equalsValue(
      this as BookingModel,
      other,
    );
  }

  @override
  int get hashCode {
    return BookingModelMapper.ensureInitialized().hashValue(
      this as BookingModel,
    );
  }
}

extension BookingModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BookingModel, $Out> {
  BookingModelCopyWith<$R, BookingModel, $Out> get $asBookingModel =>
      $base.as((v, t, t2) => _BookingModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BookingModelCopyWith<$R, $In extends BookingModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    StayExtraModel,
    StayExtraModelCopyWith<$R, StayExtraModel, StayExtraModel>
  >
  get selectedExtras;
  $R call({
    String? id,
    String? businessId,
    String? businessOwnerId,
    String? customerId,
    String? customerName,
    String? customerEmail,
    String? businessName,
    String? businessCity,
    String? businessImageUrl,
    DateTime? checkIn,
    DateTime? checkOut,
    int? adults,
    int? children,
    int? infants,
    int? pricePerNight,
    List<StayExtraModel>? selectedExtras,
    int? roomSubtotal,
    int? discountAmount,
    int? cleaningFee,
    int? serviceFee,
    int? taxes,
    int? total,
    int? originalTotal,
    BookingStatus? status,
    PaymentStatus? paymentStatus,
    String? paymentMethod,
    String? confirmationCode,
    CurrencyCode? currency,
    String? roomType,
    String? roomTypeId,
    String? customerAvatarUrl,
    DateTime? createdAt,
  });
  BookingModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BookingModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BookingModel, $Out>
    implements BookingModelCopyWith<$R, BookingModel, $Out> {
  _BookingModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BookingModel> $mapper =
      BookingModelMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    StayExtraModel,
    StayExtraModelCopyWith<$R, StayExtraModel, StayExtraModel>
  >
  get selectedExtras => ListCopyWith(
    $value.selectedExtras,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(selectedExtras: v),
  );
  @override
  $R call({
    String? id,
    String? businessId,
    String? businessOwnerId,
    String? customerId,
    String? customerName,
    String? customerEmail,
    String? businessName,
    String? businessCity,
    String? businessImageUrl,
    DateTime? checkIn,
    DateTime? checkOut,
    int? adults,
    int? children,
    int? infants,
    int? pricePerNight,
    List<StayExtraModel>? selectedExtras,
    int? roomSubtotal,
    int? discountAmount,
    int? cleaningFee,
    int? serviceFee,
    int? taxes,
    int? total,
    int? originalTotal,
    BookingStatus? status,
    PaymentStatus? paymentStatus,
    String? paymentMethod,
    String? confirmationCode,
    CurrencyCode? currency,
    Object? roomType = $none,
    Object? roomTypeId = $none,
    Object? customerAvatarUrl = $none,
    Object? createdAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (businessId != null) #businessId: businessId,
      if (businessOwnerId != null) #businessOwnerId: businessOwnerId,
      if (customerId != null) #customerId: customerId,
      if (customerName != null) #customerName: customerName,
      if (customerEmail != null) #customerEmail: customerEmail,
      if (businessName != null) #businessName: businessName,
      if (businessCity != null) #businessCity: businessCity,
      if (businessImageUrl != null) #businessImageUrl: businessImageUrl,
      if (checkIn != null) #checkIn: checkIn,
      if (checkOut != null) #checkOut: checkOut,
      if (adults != null) #adults: adults,
      if (children != null) #children: children,
      if (infants != null) #infants: infants,
      if (pricePerNight != null) #pricePerNight: pricePerNight,
      if (selectedExtras != null) #selectedExtras: selectedExtras,
      if (roomSubtotal != null) #roomSubtotal: roomSubtotal,
      if (discountAmount != null) #discountAmount: discountAmount,
      if (cleaningFee != null) #cleaningFee: cleaningFee,
      if (serviceFee != null) #serviceFee: serviceFee,
      if (taxes != null) #taxes: taxes,
      if (total != null) #total: total,
      if (originalTotal != null) #originalTotal: originalTotal,
      if (status != null) #status: status,
      if (paymentStatus != null) #paymentStatus: paymentStatus,
      if (paymentMethod != null) #paymentMethod: paymentMethod,
      if (confirmationCode != null) #confirmationCode: confirmationCode,
      if (currency != null) #currency: currency,
      if (roomType != $none) #roomType: roomType,
      if (roomTypeId != $none) #roomTypeId: roomTypeId,
      if (customerAvatarUrl != $none) #customerAvatarUrl: customerAvatarUrl,
      if (createdAt != $none) #createdAt: createdAt,
    }),
  );
  @override
  BookingModel $make(CopyWithData data) => BookingModel(
    id: data.get(#id, or: $value.id),
    businessId: data.get(#businessId, or: $value.businessId),
    businessOwnerId: data.get(#businessOwnerId, or: $value.businessOwnerId),
    customerId: data.get(#customerId, or: $value.customerId),
    customerName: data.get(#customerName, or: $value.customerName),
    customerEmail: data.get(#customerEmail, or: $value.customerEmail),
    businessName: data.get(#businessName, or: $value.businessName),
    businessCity: data.get(#businessCity, or: $value.businessCity),
    businessImageUrl: data.get(#businessImageUrl, or: $value.businessImageUrl),
    checkIn: data.get(#checkIn, or: $value.checkIn),
    checkOut: data.get(#checkOut, or: $value.checkOut),
    adults: data.get(#adults, or: $value.adults),
    children: data.get(#children, or: $value.children),
    infants: data.get(#infants, or: $value.infants),
    pricePerNight: data.get(#pricePerNight, or: $value.pricePerNight),
    selectedExtras: data.get(#selectedExtras, or: $value.selectedExtras),
    roomSubtotal: data.get(#roomSubtotal, or: $value.roomSubtotal),
    discountAmount: data.get(#discountAmount, or: $value.discountAmount),
    cleaningFee: data.get(#cleaningFee, or: $value.cleaningFee),
    serviceFee: data.get(#serviceFee, or: $value.serviceFee),
    taxes: data.get(#taxes, or: $value.taxes),
    total: data.get(#total, or: $value.total),
    originalTotal: data.get(#originalTotal, or: $value.originalTotal),
    status: data.get(#status, or: $value.status),
    paymentStatus: data.get(#paymentStatus, or: $value.paymentStatus),
    paymentMethod: data.get(#paymentMethod, or: $value.paymentMethod),
    confirmationCode: data.get(#confirmationCode, or: $value.confirmationCode),
    currency: data.get(#currency, or: $value.currency),
    roomType: data.get(#roomType, or: $value.roomType),
    roomTypeId: data.get(#roomTypeId, or: $value.roomTypeId),
    customerAvatarUrl: data.get(
      #customerAvatarUrl,
      or: $value.customerAvatarUrl,
    ),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  BookingModelCopyWith<$R2, BookingModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BookingModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

