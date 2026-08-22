class BusinessMetrics {
  const BusinessMetrics({this.activeBookings = 0, this.activeAppointments = 0});

  factory BusinessMetrics.fromJson(Map<String, dynamic>? json) =>
      BusinessMetrics(
        activeBookings: (json?['activeBookings'] as num?)?.toInt() ?? 0,
        activeAppointments: (json?['activeAppointments'] as num?)?.toInt() ?? 0,
      );

  final int activeBookings;
  final int activeAppointments;
}
