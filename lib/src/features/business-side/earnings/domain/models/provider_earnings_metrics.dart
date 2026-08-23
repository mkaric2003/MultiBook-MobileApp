class ProviderEarningsMetrics {
  const ProviderEarningsMetrics({
    this.grossRevenue = 0,
    this.providerEarnings = 0,
    this.appointmentCount = 0,
    this.dailyGrossRevenue = const {},
    this.dailyProviderEarnings = const {},
    this.dailyAppointments = const {},
  });

  factory ProviderEarningsMetrics.fromJson(Map<String, dynamic> json) =>
      ProviderEarningsMetrics(
        grossRevenue: (json['grossRevenue'] as num?)?.toDouble() ?? 0,
        providerEarnings: (json['providerEarnings'] as num?)?.toDouble() ?? 0,
        appointmentCount: (json['appointmentCount'] as num?)?.toInt() ?? 0,
        dailyGrossRevenue: _numberMap(json['dailyGrossRevenue']),
        dailyProviderEarnings: _numberMap(json['dailyProviderEarnings']),
        dailyAppointments: _numberMap(json['dailyAppointments']),
      );

  final double grossRevenue;
  final double providerEarnings;
  final int appointmentCount;
  final Map<String, double> dailyGrossRevenue;
  final Map<String, double> dailyProviderEarnings;
  final Map<String, double> dailyAppointments;

  static Map<String, double> _numberMap(Object? value) {
    if (value is! Map) return const {};
    return value.map(
      (key, item) => MapEntry(key.toString(), (item as num?)?.toDouble() ?? 0),
    );
  }
}
