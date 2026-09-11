// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'earnings_metrics.dart';

class EarningsMetricsMapper extends ClassMapperBase<EarningsMetrics> {
  EarningsMetricsMapper._();

  static EarningsMetricsMapper? _instance;
  static EarningsMetricsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EarningsMetricsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'EarningsMetrics';

  static String _$businessId(EarningsMetrics v) => v.businessId;
  static const Field<EarningsMetrics, String> _f$businessId = Field(
    'businessId',
    _$businessId,
  );
  static String _$businessType(EarningsMetrics v) => v.businessType;
  static const Field<EarningsMetrics, String> _f$businessType = Field(
    'businessType',
    _$businessType,
  );
  static String _$currency(EarningsMetrics v) => v.currency;
  static const Field<EarningsMetrics, String> _f$currency = Field(
    'currency',
    _$currency,
  );
  static String _$startDate(EarningsMetrics v) => v.startDate;
  static const Field<EarningsMetrics, String> _f$startDate = Field(
    'startDate',
    _$startDate,
  );
  static String _$endDate(EarningsMetrics v) => v.endDate;
  static const Field<EarningsMetrics, String> _f$endDate = Field(
    'endDate',
    _$endDate,
  );
  static int _$revenueMinor(EarningsMetrics v) => v.revenueMinor;
  static const Field<EarningsMetrics, int> _f$revenueMinor = Field(
    'revenueMinor',
    _$revenueMinor,
  );
  static int _$reservationCount(EarningsMetrics v) => v.reservationCount;
  static const Field<EarningsMetrics, int> _f$reservationCount = Field(
    'reservationCount',
    _$reservationCount,
  );
  static int _$onlineRevenueMinor(EarningsMetrics v) => v.onlineRevenueMinor;
  static const Field<EarningsMetrics, int> _f$onlineRevenueMinor = Field(
    'onlineRevenueMinor',
    _$onlineRevenueMinor,
  );
  static int _$cashRevenueMinor(EarningsMetrics v) => v.cashRevenueMinor;
  static const Field<EarningsMetrics, int> _f$cashRevenueMinor = Field(
    'cashRevenueMinor',
    _$cashRevenueMinor,
  );
  static int _$staffEarningsMinor(EarningsMetrics v) => v.staffEarningsMinor;
  static const Field<EarningsMetrics, int> _f$staffEarningsMinor = Field(
    'staffEarningsMinor',
    _$staffEarningsMinor,
  );
  static Map<String, int> _$dailyRevenueMinor(EarningsMetrics v) =>
      v.dailyRevenueMinor;
  static const Field<EarningsMetrics, Map<String, int>> _f$dailyRevenueMinor =
      Field('dailyRevenueMinor', _$dailyRevenueMinor);
  static Map<String, int> _$dailyReservationCount(EarningsMetrics v) =>
      v.dailyReservationCount;
  static const Field<EarningsMetrics, Map<String, int>>
  _f$dailyReservationCount = Field(
    'dailyReservationCount',
    _$dailyReservationCount,
  );
  static Map<String, int> _$dailyOnlineRevenueMinor(EarningsMetrics v) =>
      v.dailyOnlineRevenueMinor;
  static const Field<EarningsMetrics, Map<String, int>>
  _f$dailyOnlineRevenueMinor = Field(
    'dailyOnlineRevenueMinor',
    _$dailyOnlineRevenueMinor,
  );
  static Map<String, int> _$dailyCashRevenueMinor(EarningsMetrics v) =>
      v.dailyCashRevenueMinor;
  static const Field<EarningsMetrics, Map<String, int>>
  _f$dailyCashRevenueMinor = Field(
    'dailyCashRevenueMinor',
    _$dailyCashRevenueMinor,
  );
  static Map<String, int> _$dailyStaffEarningsMinor(EarningsMetrics v) =>
      v.dailyStaffEarningsMinor;
  static const Field<EarningsMetrics, Map<String, int>>
  _f$dailyStaffEarningsMinor = Field(
    'dailyStaffEarningsMinor',
    _$dailyStaffEarningsMinor,
  );
  static String? _$staffId(EarningsMetrics v) => v.staffId;
  static const Field<EarningsMetrics, String> _f$staffId = Field(
    'staffId',
    _$staffId,
    opt: true,
  );

  @override
  final MappableFields<EarningsMetrics> fields = const {
    #businessId: _f$businessId,
    #businessType: _f$businessType,
    #currency: _f$currency,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
    #revenueMinor: _f$revenueMinor,
    #reservationCount: _f$reservationCount,
    #onlineRevenueMinor: _f$onlineRevenueMinor,
    #cashRevenueMinor: _f$cashRevenueMinor,
    #staffEarningsMinor: _f$staffEarningsMinor,
    #dailyRevenueMinor: _f$dailyRevenueMinor,
    #dailyReservationCount: _f$dailyReservationCount,
    #dailyOnlineRevenueMinor: _f$dailyOnlineRevenueMinor,
    #dailyCashRevenueMinor: _f$dailyCashRevenueMinor,
    #dailyStaffEarningsMinor: _f$dailyStaffEarningsMinor,
    #staffId: _f$staffId,
  };

  static EarningsMetrics _instantiate(DecodingData data) {
    return EarningsMetrics(
      businessId: data.dec(_f$businessId),
      businessType: data.dec(_f$businessType),
      currency: data.dec(_f$currency),
      startDate: data.dec(_f$startDate),
      endDate: data.dec(_f$endDate),
      revenueMinor: data.dec(_f$revenueMinor),
      reservationCount: data.dec(_f$reservationCount),
      onlineRevenueMinor: data.dec(_f$onlineRevenueMinor),
      cashRevenueMinor: data.dec(_f$cashRevenueMinor),
      staffEarningsMinor: data.dec(_f$staffEarningsMinor),
      dailyRevenueMinor: data.dec(_f$dailyRevenueMinor),
      dailyReservationCount: data.dec(_f$dailyReservationCount),
      dailyOnlineRevenueMinor: data.dec(_f$dailyOnlineRevenueMinor),
      dailyCashRevenueMinor: data.dec(_f$dailyCashRevenueMinor),
      dailyStaffEarningsMinor: data.dec(_f$dailyStaffEarningsMinor),
      staffId: data.dec(_f$staffId),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static EarningsMetrics fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EarningsMetrics>(map);
  }

  static EarningsMetrics fromJson(String json) {
    return ensureInitialized().decodeJson<EarningsMetrics>(json);
  }
}
mixin EarningsMetricsMappable {
  String toJson() {
    return EarningsMetricsMapper.ensureInitialized()
        .encodeJson<EarningsMetrics>(this as EarningsMetrics);
  }

  Map<String, dynamic> toMap() {
    return EarningsMetricsMapper.ensureInitialized().encodeMap<EarningsMetrics>(
      this as EarningsMetrics,
    );
  }

  EarningsMetricsCopyWith<EarningsMetrics, EarningsMetrics, EarningsMetrics>
  get copyWith =>
      _EarningsMetricsCopyWithImpl<EarningsMetrics, EarningsMetrics>(
        this as EarningsMetrics,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return EarningsMetricsMapper.ensureInitialized().stringifyValue(
      this as EarningsMetrics,
    );
  }

  @override
  bool operator ==(Object other) {
    return EarningsMetricsMapper.ensureInitialized().equalsValue(
      this as EarningsMetrics,
      other,
    );
  }

  @override
  int get hashCode {
    return EarningsMetricsMapper.ensureInitialized().hashValue(
      this as EarningsMetrics,
    );
  }
}

extension EarningsMetricsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EarningsMetrics, $Out> {
  EarningsMetricsCopyWith<$R, EarningsMetrics, $Out> get $asEarningsMetrics =>
      $base.as((v, t, t2) => _EarningsMetricsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EarningsMetricsCopyWith<$R, $In extends EarningsMetrics, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get dailyRevenueMinor;
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get dailyReservationCount;
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get dailyOnlineRevenueMinor;
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get dailyCashRevenueMinor;
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get dailyStaffEarningsMinor;
  $R call({
    String? businessId,
    String? businessType,
    String? currency,
    String? startDate,
    String? endDate,
    int? revenueMinor,
    int? reservationCount,
    int? onlineRevenueMinor,
    int? cashRevenueMinor,
    int? staffEarningsMinor,
    Map<String, int>? dailyRevenueMinor,
    Map<String, int>? dailyReservationCount,
    Map<String, int>? dailyOnlineRevenueMinor,
    Map<String, int>? dailyCashRevenueMinor,
    Map<String, int>? dailyStaffEarningsMinor,
    String? staffId,
  });
  EarningsMetricsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _EarningsMetricsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EarningsMetrics, $Out>
    implements EarningsMetricsCopyWith<$R, EarningsMetrics, $Out> {
  _EarningsMetricsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EarningsMetrics> $mapper =
      EarningsMetricsMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get dailyRevenueMinor => MapCopyWith(
    $value.dailyRevenueMinor,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(dailyRevenueMinor: v),
  );
  @override
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get dailyReservationCount => MapCopyWith(
    $value.dailyReservationCount,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(dailyReservationCount: v),
  );
  @override
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get dailyOnlineRevenueMinor => MapCopyWith(
    $value.dailyOnlineRevenueMinor,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(dailyOnlineRevenueMinor: v),
  );
  @override
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get dailyCashRevenueMinor => MapCopyWith(
    $value.dailyCashRevenueMinor,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(dailyCashRevenueMinor: v),
  );
  @override
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get dailyStaffEarningsMinor => MapCopyWith(
    $value.dailyStaffEarningsMinor,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(dailyStaffEarningsMinor: v),
  );
  @override
  $R call({
    String? businessId,
    String? businessType,
    String? currency,
    String? startDate,
    String? endDate,
    int? revenueMinor,
    int? reservationCount,
    int? onlineRevenueMinor,
    int? cashRevenueMinor,
    int? staffEarningsMinor,
    Map<String, int>? dailyRevenueMinor,
    Map<String, int>? dailyReservationCount,
    Map<String, int>? dailyOnlineRevenueMinor,
    Map<String, int>? dailyCashRevenueMinor,
    Map<String, int>? dailyStaffEarningsMinor,
    Object? staffId = $none,
  }) => $apply(
    FieldCopyWithData({
      if (businessId != null) #businessId: businessId,
      if (businessType != null) #businessType: businessType,
      if (currency != null) #currency: currency,
      if (startDate != null) #startDate: startDate,
      if (endDate != null) #endDate: endDate,
      if (revenueMinor != null) #revenueMinor: revenueMinor,
      if (reservationCount != null) #reservationCount: reservationCount,
      if (onlineRevenueMinor != null) #onlineRevenueMinor: onlineRevenueMinor,
      if (cashRevenueMinor != null) #cashRevenueMinor: cashRevenueMinor,
      if (staffEarningsMinor != null) #staffEarningsMinor: staffEarningsMinor,
      if (dailyRevenueMinor != null) #dailyRevenueMinor: dailyRevenueMinor,
      if (dailyReservationCount != null)
        #dailyReservationCount: dailyReservationCount,
      if (dailyOnlineRevenueMinor != null)
        #dailyOnlineRevenueMinor: dailyOnlineRevenueMinor,
      if (dailyCashRevenueMinor != null)
        #dailyCashRevenueMinor: dailyCashRevenueMinor,
      if (dailyStaffEarningsMinor != null)
        #dailyStaffEarningsMinor: dailyStaffEarningsMinor,
      if (staffId != $none) #staffId: staffId,
    }),
  );
  @override
  EarningsMetrics $make(CopyWithData data) => EarningsMetrics(
    businessId: data.get(#businessId, or: $value.businessId),
    businessType: data.get(#businessType, or: $value.businessType),
    currency: data.get(#currency, or: $value.currency),
    startDate: data.get(#startDate, or: $value.startDate),
    endDate: data.get(#endDate, or: $value.endDate),
    revenueMinor: data.get(#revenueMinor, or: $value.revenueMinor),
    reservationCount: data.get(#reservationCount, or: $value.reservationCount),
    onlineRevenueMinor: data.get(
      #onlineRevenueMinor,
      or: $value.onlineRevenueMinor,
    ),
    cashRevenueMinor: data.get(#cashRevenueMinor, or: $value.cashRevenueMinor),
    staffEarningsMinor: data.get(
      #staffEarningsMinor,
      or: $value.staffEarningsMinor,
    ),
    dailyRevenueMinor: data.get(
      #dailyRevenueMinor,
      or: $value.dailyRevenueMinor,
    ),
    dailyReservationCount: data.get(
      #dailyReservationCount,
      or: $value.dailyReservationCount,
    ),
    dailyOnlineRevenueMinor: data.get(
      #dailyOnlineRevenueMinor,
      or: $value.dailyOnlineRevenueMinor,
    ),
    dailyCashRevenueMinor: data.get(
      #dailyCashRevenueMinor,
      or: $value.dailyCashRevenueMinor,
    ),
    dailyStaffEarningsMinor: data.get(
      #dailyStaffEarningsMinor,
      or: $value.dailyStaffEarningsMinor,
    ),
    staffId: data.get(#staffId, or: $value.staffId),
  );

  @override
  EarningsMetricsCopyWith<$R2, EarningsMetrics, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _EarningsMetricsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
