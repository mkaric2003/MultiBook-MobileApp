class RateBusinessState {
  const RateBusinessState({
    this.isSubmitting = false,
    this.isSubmitted = false,
    this.errorMessage,
  });

  final bool isSubmitting;
  final bool isSubmitted;
  final String? errorMessage;

  RateBusinessState copyWith({
    bool? isSubmitting,
    bool? isSubmitted,
    String? errorMessage,
  }) => RateBusinessState(
    isSubmitting: isSubmitting ?? this.isSubmitting,
    isSubmitted: isSubmitted ?? this.isSubmitted,
    errorMessage: errorMessage,
  );
}
