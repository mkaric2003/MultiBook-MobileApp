sealed class HomeEvent {
  const HomeEvent();
}

class LogoutRequested extends HomeEvent {
  const LogoutRequested();
}

class UpdateTabIndex extends HomeEvent {
  const UpdateTabIndex(this.tabIndex);

  final int tabIndex;
}
