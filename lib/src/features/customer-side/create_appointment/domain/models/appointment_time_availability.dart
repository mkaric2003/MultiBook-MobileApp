class AppointmentTimeAvailability {
  const AppointmentTimeAvailability({
    required this.availableTimes,
    required this.bookableStartTimes,
  });

  final List<int> availableTimes;
  final Set<int> bookableStartTimes;
}
