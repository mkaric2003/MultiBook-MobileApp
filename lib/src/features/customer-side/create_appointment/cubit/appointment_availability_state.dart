class AppointmentAvailabilityState {
  const AppointmentAvailabilityState({
    this.isLoading = false,
    this.bookedStartMinutes = const {},
    this.errorMessage,
  });

  final bool isLoading;
  final Set<int> bookedStartMinutes;
  final String? errorMessage;

  AppointmentAvailabilityState copyWith({
    bool? isLoading,
    Set<int>? bookedStartMinutes,
    String? errorMessage,
    bool clearError = false,
  }) => AppointmentAvailabilityState(
    isLoading: isLoading ?? this.isLoading,
    bookedStartMinutes: bookedStartMinutes ?? this.bookedStartMinutes,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );
}
