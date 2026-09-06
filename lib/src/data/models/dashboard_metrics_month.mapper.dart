// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'dashboard_metrics_month.dart';

class DashboardMetricsMonthMapper
    extends ClassMapperBase<DashboardMetricsMonth> {
  DashboardMetricsMonthMapper._();

  static DashboardMetricsMonthMapper? _instance;
  static DashboardMetricsMonthMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DashboardMetricsMonthMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DashboardMetricsMonth';

  static String _$monthKey(DashboardMetricsMonth v) => v.monthKey;
  static const Field<DashboardMetricsMonth, String> _f$monthKey = Field(
    'monthKey',
    _$monthKey,
  );
  static int _$revenueMinor(DashboardMetricsMonth v) => v.revenueMinor;
  static const Field<DashboardMetricsMonth, int> _f$revenueMinor = Field(
    'revenueMinor',
    _$revenueMinor,
  );
  static int _$reservationCount(DashboardMetricsMonth v) => v.reservationCount;
  static const Field<DashboardMetricsMonth, int> _f$reservationCount = Field(
    'reservationCount',
    _$reservationCount,
  );
  static Map<String, int> _$dailyRevenueMinor(DashboardMetricsMonth v) =>
      v.dailyRevenueMinor;
  static const Field<DashboardMetricsMonth, Map<String, int>>
  _f$dailyRevenueMinor = Field('dailyRevenueMinor', _$dailyRevenueMinor);
  static Map<String, int> _$dailyReservationCount(DashboardMetricsMonth v) =>
      v.dailyReservationCount;
  static const Field<DashboardMetricsMonth, Map<String, int>>
  _f$dailyReservationCount = Field(
    'dailyReservationCount',
    _$dailyReservationCount,
  );

  @override
  final MappableFields<DashboardMetricsMonth> fields = const {
    #monthKey: _f$monthKey,
    #revenueMinor: _f$revenueMinor,
    #reservationCount: _f$reservationCount,
    #dailyRevenueMinor: _f$dailyRevenueMinor,
    #dailyReservationCount: _f$dailyReservationCount,
  };

  static DashboardMetricsMonth _instantiate(DecodingData data) {
    return DashboardMetricsMonth(
      monthKey: data.dec(_f$monthKey),
      revenueMinor: data.dec(_f$revenueMinor),
      reservationCount: data.dec(_f$reservationCount),
      dailyRevenueMinor: data.dec(_f$dailyRevenueMinor),
      dailyReservationCount: data.dec(_f$dailyReservationCount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DashboardMetricsMonth fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DashboardMetricsMonth>(map);
  }

  static DashboardMetricsMonth fromJson(String json) {
    return ensureInitialized().decodeJson<DashboardMetricsMonth>(json);
  }
}

mixin DashboardMetricsMonthMappable {
  String toJson() {
    return DashboardMetricsMonthMapper.ensureInitialized()
        .encodeJson<DashboardMetricsMonth>(this as DashboardMetricsMonth);
  }

  Map<String, dynamic> toMap() {
    return DashboardMetricsMonthMapper.ensureInitialized()
        .encodeMap<DashboardMetricsMonth>(this as DashboardMetricsMonth);
  }

  DashboardMetricsMonthCopyWith<
    DashboardMetricsMonth,
    DashboardMetricsMonth,
    DashboardMetricsMonth
  >
  get copyWith =>
      _DashboardMetricsMonthCopyWithImpl<
        DashboardMetricsMonth,
        DashboardMetricsMonth
      >(this as DashboardMetricsMonth, $identity, $identity);
  @override
  String toString() {
    return DashboardMetricsMonthMapper.ensureInitialized().stringifyValue(
      this as DashboardMetricsMonth,
    );
  }

  @override
  bool operator ==(Object other) {
    return DashboardMetricsMonthMapper.ensureInitialized().equalsValue(
      this as DashboardMetricsMonth,
      other,
    );
  }

  @override
  int get hashCode {
    return DashboardMetricsMonthMapper.ensureInitialized().hashValue(
      this as DashboardMetricsMonth,
    );
  }
}

extension DashboardMetricsMonthValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DashboardMetricsMonth, $Out> {
  DashboardMetricsMonthCopyWith<$R, DashboardMetricsMonth, $Out>
  get $asDashboardMetricsMonth => $base.as(
    (v, t, t2) => _DashboardMetricsMonthCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class DashboardMetricsMonthCopyWith<
  $R,
  $In extends DashboardMetricsMonth,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get dailyRevenueMinor;
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get dailyReservationCount;
  $R call({
    String? monthKey,
    int? revenueMinor,
    int? reservationCount,
    Map<String, int>? dailyRevenueMinor,
    Map<String, int>? dailyReservationCount,
  });
  DashboardMetricsMonthCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DashboardMetricsMonthCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DashboardMetricsMonth, $Out>
    implements DashboardMetricsMonthCopyWith<$R, DashboardMetricsMonth, $Out> {
  _DashboardMetricsMonthCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DashboardMetricsMonth> $mapper =
      DashboardMetricsMonthMapper.ensureInitialized();
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
  $R call({
    String? monthKey,
    int? revenueMinor,
    int? reservationCount,
    Map<String, int>? dailyRevenueMinor,
    Map<String, int>? dailyReservationCount,
  }) => $apply(
    FieldCopyWithData({
      if (monthKey != null) #monthKey: monthKey,
      if (revenueMinor != null) #revenueMinor: revenueMinor,
      if (reservationCount != null) #reservationCount: reservationCount,
      if (dailyRevenueMinor != null) #dailyRevenueMinor: dailyRevenueMinor,
      if (dailyReservationCount != null)
        #dailyReservationCount: dailyReservationCount,
    }),
  );
  @override
  DashboardMetricsMonth $make(CopyWithData data) => DashboardMetricsMonth(
    monthKey: data.get(#monthKey, or: $value.monthKey),
    revenueMinor: data.get(#revenueMinor, or: $value.revenueMinor),
    reservationCount: data.get(#reservationCount, or: $value.reservationCount),
    dailyRevenueMinor: data.get(
      #dailyRevenueMinor,
      or: $value.dailyRevenueMinor,
    ),
    dailyReservationCount: data.get(
      #dailyReservationCount,
      or: $value.dailyReservationCount,
    ),
  );

  @override
  DashboardMetricsMonthCopyWith<$R2, DashboardMetricsMonth, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _DashboardMetricsMonthCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
