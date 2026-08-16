class CustomerProfileState {
  const CustomerProfileState({
    this.isLoading = false,
    this.isSignedOut = false,
    this.errorMessage,
  });

  final bool isLoading;
  final bool isSignedOut;
  final String? errorMessage;
}
