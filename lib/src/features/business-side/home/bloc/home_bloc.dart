import 'package:aquabook/src/data/repositories/authentication_repository.dart';
import 'package:aquabook/src/features/business-side/home/bloc/home_event.dart';
import 'package:aquabook/src/features/business-side/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._authenticationRepository) : super(const HomeState()) {
    on<LogoutRequested>(_onLogoutRequested);
    on<UpdateTabIndex>(_onUpdateTabIndex);
  }

  final AuthenticationRepository _authenticationRepository;

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeState(isLoading: true));

    try {
      await _authenticationRepository.signOut();
      if (!emit.isDone) {
        emit(const HomeState(isSignedOut: true));
      }
    } on AuthenticationException catch (error) {
      if (!emit.isDone) {
        emit(HomeState(errorMessage: error.message));
      }
    }
  }

  void _onUpdateTabIndex(UpdateTabIndex event, Emitter<HomeState> emit) {
    emit(HomeState(currentTabIndex: event.tabIndex));
  }
}
