class AppointmentAvailabilityState {
  const AppointmentAvailabilityState({
    this.isLoading = false,
    this.availableStartMinutes = const {},
    this.errorMessage,
  });

  final bool isLoading;
  final Set<int> availableStartMinutes;
  final String? errorMessage;

  AppointmentAvailabilityState copyWith({
    bool? isLoading,
    Set<int>? availableStartMinutes,
    String? errorMessage,
    bool clearError = false,
  }) => AppointmentAvailabilityState(
    isLoading: isLoading ?? this.isLoading,
    availableStartMinutes: availableStartMinutes ?? this.availableStartMinutes,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );
}
