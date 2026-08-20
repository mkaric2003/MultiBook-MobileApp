enum UserLocationStatus {
  idle,
  needsPermission,
  loading,
  complete,
  error,
  skipped,
}

class UserLocationState {
  const UserLocationState({
    this.status = UserLocationStatus.idle,
    this.errorMessage,
    this.canOpenSettings = false,
  });

  final UserLocationStatus status;
  final String? errorMessage;
  final bool canOpenSettings;
}
