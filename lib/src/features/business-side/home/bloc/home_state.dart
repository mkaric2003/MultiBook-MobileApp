class HomeState {
  const HomeState({
    this.isLoading = false,
    this.isSignedOut = false,
    this.errorMessage,
    this.currentTabIndex = 0,
  });

  final bool isLoading;
  final bool isSignedOut;
  final String? errorMessage;
  final int currentTabIndex;
}
