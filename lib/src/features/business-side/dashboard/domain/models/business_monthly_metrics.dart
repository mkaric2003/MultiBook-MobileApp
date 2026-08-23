class BusinessMonthlyMetrics {
  const BusinessMonthlyMetrics({
    this.revenue = 0,
    this.bookingCount = 0,
    this.onlineEarnings = 0,
    this.cashEarnings = 0,
    this.dailyRevenue = const {},
    this.dailyBookings = const {},
  });

  factory BusinessMonthlyMetrics.fromJson(Map<String, dynamic>? json) =>
      BusinessMonthlyMetrics(
        revenue: (json?['revenue'] as num?)?.toDouble() ?? 0,
        bookingCount: (json?['bookingCount'] as num?)?.toInt() ?? 0,
        onlineEarnings: (json?['onlineEarnings'] as num?)?.toDouble() ?? 0,
        cashEarnings: (json?['cashEarnings'] as num?)?.toDouble() ?? 0,
        dailyRevenue: _numberMap(json?['dailyRevenue']),
        dailyBookings: _numberMap(json?['dailyBookings']),
      );

  final double revenue;
  final int bookingCount;
  final double onlineEarnings;
  final double cashEarnings;
  final Map<String, double> dailyRevenue;
  final Map<String, double> dailyBookings;

  static Map<String, double> _numberMap(Object? value) {
    if (value is! Map) return const {};
    return value.map(
      (key, item) => MapEntry(key.toString(), (item as num?)?.toDouble() ?? 0),
    );
  }
}
