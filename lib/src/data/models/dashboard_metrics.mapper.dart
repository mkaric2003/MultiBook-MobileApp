// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'dashboard_metrics.dart';

class DashboardMetricsMapper extends ClassMapperBase<DashboardMetrics> {
  DashboardMetricsMapper._();

  static DashboardMetricsMapper? _instance;
  static DashboardMetricsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DashboardMetricsMapper._());
      DashboardMetricsMonthMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DashboardMetrics';

  static String _$businessId(DashboardMetrics v) => v.businessId;
  static const Field<DashboardMetrics, String> _f$businessId = Field(
    'businessId',
    _$businessId,
  );
  static String _$businessType(DashboardMetrics v) => v.businessType;
  static const Field<DashboardMetrics, String> _f$businessType = Field(
    'businessType',
    _$businessType,
  );
  static String _$currency(DashboardMetrics v) => v.currency;
  static const Field<DashboardMetrics, String> _f$currency = Field(
    'currency',
    _$currency,
  );
  static int _$activeReservationCount(DashboardMetrics v) =>
      v.activeReservationCount;
  static const Field<DashboardMetrics, int> _f$activeReservationCount = Field(
    'activeReservationCount',
    _$activeReservationCount,
  );
  static DashboardMetricsMonth _$currentMonth(DashboardMetrics v) =>
      v.currentMonth;
  static const Field<DashboardMetrics, DashboardMetricsMonth> _f$currentMonth =
      Field('currentMonth', _$currentMonth);

  @override
  final MappableFields<DashboardMetrics> fields = const {
    #businessId: _f$businessId,
    #businessType: _f$businessType,
    #currency: _f$currency,
    #activeReservationCount: _f$activeReservationCount,
    #currentMonth: _f$currentMonth,
  };

  static DashboardMetrics _instantiate(DecodingData data) {
    return DashboardMetrics(
      businessId: data.dec(_f$businessId),
      businessType: data.dec(_f$businessType),
      currency: data.dec(_f$currency),
      activeReservationCount: data.dec(_f$activeReservationCount),
      currentMonth: data.dec(_f$currentMonth),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DashboardMetrics fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DashboardMetrics>(map);
  }

  static DashboardMetrics fromJson(String json) {
    return ensureInitialized().decodeJson<DashboardMetrics>(json);
  }
}

mixin DashboardMetricsMappable {
  String toJson() {
    return DashboardMetricsMapper.ensureInitialized()
        .encodeJson<DashboardMetrics>(this as DashboardMetrics);
  }

  Map<String, dynamic> toMap() {
    return DashboardMetricsMapper.ensureInitialized()
        .encodeMap<DashboardMetrics>(this as DashboardMetrics);
  }

  DashboardMetricsCopyWith<DashboardMetrics, DashboardMetrics, DashboardMetrics>
  get copyWith =>
      _DashboardMetricsCopyWithImpl<DashboardMetrics, DashboardMetrics>(
        this as DashboardMetrics,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DashboardMetricsMapper.ensureInitialized().stringifyValue(
      this as DashboardMetrics,
    );
  }

  @override
  bool operator ==(Object other) {
    return DashboardMetricsMapper.ensureInitialized().equalsValue(
      this as DashboardMetrics,
      other,
    );
  }

  @override
  int get hashCode {
    return DashboardMetricsMapper.ensureInitialized().hashValue(
      this as DashboardMetrics,
    );
  }
}

extension DashboardMetricsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DashboardMetrics, $Out> {
  DashboardMetricsCopyWith<$R, DashboardMetrics, $Out>
  get $asDashboardMetrics =>
      $base.as((v, t, t2) => _DashboardMetricsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DashboardMetricsCopyWith<$R, $In extends DashboardMetrics, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  DashboardMetricsMonthCopyWith<
    $R,
    DashboardMetricsMonth,
    DashboardMetricsMonth
  >
  get currentMonth;
  $R call({
    String? businessId,
    String? businessType,
    String? currency,
    int? activeReservationCount,
    DashboardMetricsMonth? currentMonth,
  });
  DashboardMetricsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DashboardMetricsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DashboardMetrics, $Out>
    implements DashboardMetricsCopyWith<$R, DashboardMetrics, $Out> {
  _DashboardMetricsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DashboardMetrics> $mapper =
      DashboardMetricsMapper.ensureInitialized();
  @override
  DashboardMetricsMonthCopyWith<
    $R,
    DashboardMetricsMonth,
    DashboardMetricsMonth
  >
  get currentMonth =>
      $value.currentMonth.copyWith.$chain((v) => call(currentMonth: v));
  @override
  $R call({
    String? businessId,
    String? businessType,
    String? currency,
    int? activeReservationCount,
    DashboardMetricsMonth? currentMonth,
  }) => $apply(
    FieldCopyWithData({
      if (businessId != null) #businessId: businessId,
      if (businessType != null) #businessType: businessType,
      if (currency != null) #currency: currency,
      if (activeReservationCount != null)
        #activeReservationCount: activeReservationCount,
      if (currentMonth != null) #currentMonth: currentMonth,
    }),
  );
  @override
  DashboardMetrics $make(CopyWithData data) => DashboardMetrics(
    businessId: data.get(#businessId, or: $value.businessId),
    businessType: data.get(#businessType, or: $value.businessType),
    currency: data.get(#currency, or: $value.currency),
    activeReservationCount: data.get(
      #activeReservationCount,
      or: $value.activeReservationCount,
    ),
    currentMonth: data.get(#currentMonth, or: $value.currentMonth),
  );

  @override
  DashboardMetricsCopyWith<$R2, DashboardMetrics, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DashboardMetricsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
