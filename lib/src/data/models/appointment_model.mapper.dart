// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'appointment_model.dart';

class AppointmentModelMapper extends ClassMapperBase<AppointmentModel> {
  AppointmentModelMapper._();

  static AppointmentModelMapper? _instance;
  static AppointmentModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppointmentModelMapper._());
      PaymentStatusMapper.ensureInitialized();
      CurrencyCodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AppointmentModel';

  static String _$id(AppointmentModel v) => v.id;
  static const Field<AppointmentModel, String> _f$id = Field('id', _$id);
  static String _$businessId(AppointmentModel v) => v.businessId;
  static const Field<AppointmentModel, String> _f$businessId = Field(
    'businessId',
    _$businessId,
  );
  static String _$businessOwnerId(AppointmentModel v) => v.businessOwnerId;
  static const Field<AppointmentModel, String> _f$businessOwnerId = Field(
    'businessOwnerId',
    _$businessOwnerId,
  );
  static String _$businessName(AppointmentModel v) => v.businessName;
  static const Field<AppointmentModel, String> _f$businessName = Field(
    'businessName',
    _$businessName,
  );
  static String _$businessImageUrl(AppointmentModel v) => v.businessImageUrl;
  static const Field<AppointmentModel, String> _f$businessImageUrl = Field(
    'businessImageUrl',
    _$businessImageUrl,
  );
  static String _$customerId(AppointmentModel v) => v.customerId;
  static const Field<AppointmentModel, String> _f$customerId = Field(
    'customerId',
    _$customerId,
  );
  static String _$customerName(AppointmentModel v) => v.customerName;
  static const Field<AppointmentModel, String> _f$customerName = Field(
    'customerName',
    _$customerName,
  );
  static String _$customerEmail(AppointmentModel v) => v.customerEmail;
  static const Field<AppointmentModel, String> _f$customerEmail = Field(
    'customerEmail',
    _$customerEmail,
  );
  static String _$customerPhone(AppointmentModel v) => v.customerPhone;
  static const Field<AppointmentModel, String> _f$customerPhone = Field(
    'customerPhone',
    _$customerPhone,
  );
  static String? _$customerAvatarUrl(AppointmentModel v) => v.customerAvatarUrl;
  static const Field<AppointmentModel, String> _f$customerAvatarUrl = Field(
    'customerAvatarUrl',
    _$customerAvatarUrl,
    opt: true,
  );
  static String _$providerId(AppointmentModel v) => v.providerId;
  static const Field<AppointmentModel, String> _f$providerId = Field(
    'providerId',
    _$providerId,
  );
  static String _$providerName(AppointmentModel v) => v.providerName;
  static const Field<AppointmentModel, String> _f$providerName = Field(
    'providerName',
    _$providerName,
  );
  static double _$providerCommissionRate(AppointmentModel v) =>
      v.providerCommissionRate;
  static const Field<AppointmentModel, double> _f$providerCommissionRate =
      Field(
        'providerCommissionRate',
        _$providerCommissionRate,
        opt: true,
        def: 100,
      );
  static double _$providerEarnings(AppointmentModel v) => v.providerEarnings;
  static const Field<AppointmentModel, double> _f$providerEarnings = Field(
    'providerEarnings',
    _$providerEarnings,
    opt: true,
    def: 0,
  );
  static List<String> _$serviceIds(AppointmentModel v) => v.serviceIds;
  static const Field<AppointmentModel, List<String>> _f$serviceIds = Field(
    'serviceIds',
    _$serviceIds,
  );
  static List<String> _$serviceNames(AppointmentModel v) => v.serviceNames;
  static const Field<AppointmentModel, List<String>> _f$serviceNames = Field(
    'serviceNames',
    _$serviceNames,
  );
  static DateTime _$date(AppointmentModel v) => v.date;
  static const Field<AppointmentModel, DateTime> _f$date = Field(
    'date',
    _$date,
  );
  static int _$startMinutes(AppointmentModel v) => v.startMinutes;
  static const Field<AppointmentModel, int> _f$startMinutes = Field(
    'startMinutes',
    _$startMinutes,
  );
  static int _$endMinutes(AppointmentModel v) => v.endMinutes;
  static const Field<AppointmentModel, int> _f$endMinutes = Field(
    'endMinutes',
    _$endMinutes,
  );
  static int _$serviceCost(AppointmentModel v) => v.serviceCost;
  static const Field<AppointmentModel, int> _f$serviceCost = Field(
    'serviceCost',
    _$serviceCost,
  );
  static int _$originalServiceCost(AppointmentModel v) => v.originalServiceCost;
  static const Field<AppointmentModel, int> _f$originalServiceCost = Field(
    'originalServiceCost',
    _$originalServiceCost,
    opt: true,
    def: 0,
  );
  static int _$discountAmount(AppointmentModel v) => v.discountAmount;
  static const Field<AppointmentModel, int> _f$discountAmount = Field(
    'discountAmount',
    _$discountAmount,
    opt: true,
    def: 0,
  );
  static int _$addOnsCost(AppointmentModel v) => v.addOnsCost;
  static const Field<AppointmentModel, int> _f$addOnsCost = Field(
    'addOnsCost',
    _$addOnsCost,
  );
  static double _$serviceFee(AppointmentModel v) => v.serviceFee;
  static const Field<AppointmentModel, double> _f$serviceFee = Field(
    'serviceFee',
    _$serviceFee,
  );
  static double _$taxes(AppointmentModel v) => v.taxes;
  static const Field<AppointmentModel, double> _f$taxes = Field(
    'taxes',
    _$taxes,
  );
  static double _$total(AppointmentModel v) => v.total;
  static const Field<AppointmentModel, double> _f$total = Field(
    'total',
    _$total,
  );
  static PaymentStatus _$paymentStatus(AppointmentModel v) => v.paymentStatus;
  static const Field<AppointmentModel, PaymentStatus> _f$paymentStatus = Field(
    'paymentStatus',
    _$paymentStatus,
  );
  static String _$paymentMethod(AppointmentModel v) => v.paymentMethod;
  static const Field<AppointmentModel, String> _f$paymentMethod = Field(
    'paymentMethod',
    _$paymentMethod,
  );
  static String _$confirmationCode(AppointmentModel v) => v.confirmationCode;
  static const Field<AppointmentModel, String> _f$confirmationCode = Field(
    'confirmationCode',
    _$confirmationCode,
  );
  static CurrencyCode _$currency(AppointmentModel v) => v.currency;
  static const Field<AppointmentModel, CurrencyCode> _f$currency = Field(
    'currency',
    _$currency,
    opt: true,
    def: CurrencyCode.bam,
  );
  static String _$status(AppointmentModel v) => v.status;
  static const Field<AppointmentModel, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
    def: 'confirmed',
  );
  static int _$rescheduleCount(AppointmentModel v) => v.rescheduleCount;
  static const Field<AppointmentModel, int> _f$rescheduleCount = Field(
    'rescheduleCount',
    _$rescheduleCount,
    opt: true,
    def: 0,
  );

  @override
  final MappableFields<AppointmentModel> fields = const {
    #id: _f$id,
    #businessId: _f$businessId,
    #businessOwnerId: _f$businessOwnerId,
    #businessName: _f$businessName,
    #businessImageUrl: _f$businessImageUrl,
    #customerId: _f$customerId,
    #customerName: _f$customerName,
    #customerEmail: _f$customerEmail,
    #customerPhone: _f$customerPhone,
    #customerAvatarUrl: _f$customerAvatarUrl,
    #providerId: _f$providerId,
    #providerName: _f$providerName,
    #providerCommissionRate: _f$providerCommissionRate,
    #providerEarnings: _f$providerEarnings,
    #serviceIds: _f$serviceIds,
    #serviceNames: _f$serviceNames,
    #date: _f$date,
    #startMinutes: _f$startMinutes,
    #endMinutes: _f$endMinutes,
    #serviceCost: _f$serviceCost,
    #originalServiceCost: _f$originalServiceCost,
    #discountAmount: _f$discountAmount,
    #addOnsCost: _f$addOnsCost,
    #serviceFee: _f$serviceFee,
    #taxes: _f$taxes,
    #total: _f$total,
    #paymentStatus: _f$paymentStatus,
    #paymentMethod: _f$paymentMethod,
    #confirmationCode: _f$confirmationCode,
    #currency: _f$currency,
    #status: _f$status,
    #rescheduleCount: _f$rescheduleCount,
  };

  static AppointmentModel _instantiate(DecodingData data) {
    return AppointmentModel(
      id: data.dec(_f$id),
      businessId: data.dec(_f$businessId),
      businessOwnerId: data.dec(_f$businessOwnerId),
      businessName: data.dec(_f$businessName),
      businessImageUrl: data.dec(_f$businessImageUrl),
      customerId: data.dec(_f$customerId),
      customerName: data.dec(_f$customerName),
      customerEmail: data.dec(_f$customerEmail),
      customerPhone: data.dec(_f$customerPhone),
      customerAvatarUrl: data.dec(_f$customerAvatarUrl),
      providerId: data.dec(_f$providerId),
      providerName: data.dec(_f$providerName),
      providerCommissionRate: data.dec(_f$providerCommissionRate),
      providerEarnings: data.dec(_f$providerEarnings),
      serviceIds: data.dec(_f$serviceIds),
      serviceNames: data.dec(_f$serviceNames),
      date: data.dec(_f$date),
      startMinutes: data.dec(_f$startMinutes),
      endMinutes: data.dec(_f$endMinutes),
      serviceCost: data.dec(_f$serviceCost),
      originalServiceCost: data.dec(_f$originalServiceCost),
      discountAmount: data.dec(_f$discountAmount),
      addOnsCost: data.dec(_f$addOnsCost),
      serviceFee: data.dec(_f$serviceFee),
      taxes: data.dec(_f$taxes),
      total: data.dec(_f$total),
      paymentStatus: data.dec(_f$paymentStatus),
      paymentMethod: data.dec(_f$paymentMethod),
      confirmationCode: data.dec(_f$confirmationCode),
      currency: data.dec(_f$currency),
      status: data.dec(_f$status),
      rescheduleCount: data.dec(_f$rescheduleCount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppointmentModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppointmentModel>(map);
  }

  static AppointmentModel fromJson(String json) {
    return ensureInitialized().decodeJson<AppointmentModel>(json);
  }
}

mixin AppointmentModelMappable {
  String toJson() {
    return AppointmentModelMapper.ensureInitialized()
        .encodeJson<AppointmentModel>(this as AppointmentModel);
  }

  Map<String, dynamic> toMap() {
    return AppointmentModelMapper.ensureInitialized()
        .encodeMap<AppointmentModel>(this as AppointmentModel);
  }

  AppointmentModelCopyWith<AppointmentModel, AppointmentModel, AppointmentModel>
  get copyWith =>
      _AppointmentModelCopyWithImpl<AppointmentModel, AppointmentModel>(
        this as AppointmentModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AppointmentModelMapper.ensureInitialized().stringifyValue(
      this as AppointmentModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppointmentModelMapper.ensureInitialized().equalsValue(
      this as AppointmentModel,
      other,
    );
  }

  @override
  int get hashCode {
    return AppointmentModelMapper.ensureInitialized().hashValue(
      this as AppointmentModel,
    );
  }
}

extension AppointmentModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppointmentModel, $Out> {
  AppointmentModelCopyWith<$R, AppointmentModel, $Out>
  get $asAppointmentModel =>
      $base.as((v, t, t2) => _AppointmentModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AppointmentModelCopyWith<$R, $In extends AppointmentModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get serviceIds;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get serviceNames;
  $R call({
    String? id,
    String? businessId,
    String? businessOwnerId,
    String? businessName,
    String? businessImageUrl,
    String? customerId,
    String? customerName,
    String? customerEmail,
    String? customerPhone,
    String? customerAvatarUrl,
    String? providerId,
    String? providerName,
    double? providerCommissionRate,
    double? providerEarnings,
    List<String>? serviceIds,
    List<String>? serviceNames,
    DateTime? date,
    int? startMinutes,
    int? endMinutes,
    int? serviceCost,
    int? originalServiceCost,
    int? discountAmount,
    int? addOnsCost,
    double? serviceFee,
    double? taxes,
    double? total,
    PaymentStatus? paymentStatus,
    String? paymentMethod,
    String? confirmationCode,
    CurrencyCode? currency,
    String? status,
    int? rescheduleCount,
  });
  AppointmentModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AppointmentModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppointmentModel, $Out>
    implements AppointmentModelCopyWith<$R, AppointmentModel, $Out> {
  _AppointmentModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppointmentModel> $mapper =
      AppointmentModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get serviceIds =>
      ListCopyWith(
        $value.serviceIds,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(serviceIds: v),
      );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get serviceNames => ListCopyWith(
    $value.serviceNames,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(serviceNames: v),
  );
  @override
  $R call({
    String? id,
    String? businessId,
    String? businessOwnerId,
    String? businessName,
    String? businessImageUrl,
    String? customerId,
    String? customerName,
    String? customerEmail,
    String? customerPhone,
    Object? customerAvatarUrl = $none,
    String? providerId,
    String? providerName,
    double? providerCommissionRate,
    double? providerEarnings,
    List<String>? serviceIds,
    List<String>? serviceNames,
    DateTime? date,
    int? startMinutes,
    int? endMinutes,
    int? serviceCost,
    int? originalServiceCost,
    int? discountAmount,
    int? addOnsCost,
    double? serviceFee,
    double? taxes,
    double? total,
    PaymentStatus? paymentStatus,
    String? paymentMethod,
    String? confirmationCode,
    CurrencyCode? currency,
    String? status,
    int? rescheduleCount,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (businessId != null) #businessId: businessId,
      if (businessOwnerId != null) #businessOwnerId: businessOwnerId,
      if (businessName != null) #businessName: businessName,
      if (businessImageUrl != null) #businessImageUrl: businessImageUrl,
      if (customerId != null) #customerId: customerId,
      if (customerName != null) #customerName: customerName,
      if (customerEmail != null) #customerEmail: customerEmail,
      if (customerPhone != null) #customerPhone: customerPhone,
      if (customerAvatarUrl != $none) #customerAvatarUrl: customerAvatarUrl,
      if (providerId != null) #providerId: providerId,
      if (providerName != null) #providerName: providerName,
      if (providerCommissionRate != null)
        #providerCommissionRate: providerCommissionRate,
      if (providerEarnings != null) #providerEarnings: providerEarnings,
      if (serviceIds != null) #serviceIds: serviceIds,
      if (serviceNames != null) #serviceNames: serviceNames,
      if (date != null) #date: date,
      if (startMinutes != null) #startMinutes: startMinutes,
      if (endMinutes != null) #endMinutes: endMinutes,
      if (serviceCost != null) #serviceCost: serviceCost,
      if (originalServiceCost != null)
        #originalServiceCost: originalServiceCost,
      if (discountAmount != null) #discountAmount: discountAmount,
      if (addOnsCost != null) #addOnsCost: addOnsCost,
      if (serviceFee != null) #serviceFee: serviceFee,
      if (taxes != null) #taxes: taxes,
      if (total != null) #total: total,
      if (paymentStatus != null) #paymentStatus: paymentStatus,
      if (paymentMethod != null) #paymentMethod: paymentMethod,
      if (confirmationCode != null) #confirmationCode: confirmationCode,
      if (currency != null) #currency: currency,
      if (status != null) #status: status,
      if (rescheduleCount != null) #rescheduleCount: rescheduleCount,
    }),
  );
  @override
  AppointmentModel $make(CopyWithData data) => AppointmentModel(
    id: data.get(#id, or: $value.id),
    businessId: data.get(#businessId, or: $value.businessId),
    businessOwnerId: data.get(#businessOwnerId, or: $value.businessOwnerId),
    businessName: data.get(#businessName, or: $value.businessName),
    businessImageUrl: data.get(#businessImageUrl, or: $value.businessImageUrl),
    customerId: data.get(#customerId, or: $value.customerId),
    customerName: data.get(#customerName, or: $value.customerName),
    customerEmail: data.get(#customerEmail, or: $value.customerEmail),
    customerPhone: data.get(#customerPhone, or: $value.customerPhone),
    customerAvatarUrl: data.get(
      #customerAvatarUrl,
      or: $value.customerAvatarUrl,
    ),
    providerId: data.get(#providerId, or: $value.providerId),
    providerName: data.get(#providerName, or: $value.providerName),
    providerCommissionRate: data.get(
      #providerCommissionRate,
      or: $value.providerCommissionRate,
    ),
    providerEarnings: data.get(#providerEarnings, or: $value.providerEarnings),
    serviceIds: data.get(#serviceIds, or: $value.serviceIds),
    serviceNames: data.get(#serviceNames, or: $value.serviceNames),
    date: data.get(#date, or: $value.date),
    startMinutes: data.get(#startMinutes, or: $value.startMinutes),
    endMinutes: data.get(#endMinutes, or: $value.endMinutes),
    serviceCost: data.get(#serviceCost, or: $value.serviceCost),
    originalServiceCost: data.get(
      #originalServiceCost,
      or: $value.originalServiceCost,
    ),
    discountAmount: data.get(#discountAmount, or: $value.discountAmount),
    addOnsCost: data.get(#addOnsCost, or: $value.addOnsCost),
    serviceFee: data.get(#serviceFee, or: $value.serviceFee),
    taxes: data.get(#taxes, or: $value.taxes),
    total: data.get(#total, or: $value.total),
    paymentStatus: data.get(#paymentStatus, or: $value.paymentStatus),
    paymentMethod: data.get(#paymentMethod, or: $value.paymentMethod),
    confirmationCode: data.get(#confirmationCode, or: $value.confirmationCode),
    currency: data.get(#currency, or: $value.currency),
    status: data.get(#status, or: $value.status),
    rescheduleCount: data.get(#rescheduleCount, or: $value.rescheduleCount),
  );

  @override
  AppointmentModelCopyWith<$R2, AppointmentModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AppointmentModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

