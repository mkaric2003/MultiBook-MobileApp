import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/core/services/notification_device_service.dart';
import 'package:multibook/src/core/session/session_stream_registry.dart';
import 'package:multibook/src/data/repositories/authentication_repository.dart';
import 'package:multibook/src/domain/use_cases/chat/get_unread_messages_count_use_case.dart';
import 'package:multibook/src/domain/use_cases/chat/watch_unread_messages_count_use_case.dart';
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart';
import 'package:multibook/src/features/customer-side/profile/cubit/customer_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CustomerProfileCubit extends Cubit<CustomerProfileState>
    with WidgetsBindingObserver {
  CustomerProfileCubit(
    this._authenticationRepository,
    this._userRepository,
    this._watchUnreadMessagesCount,
    this._getUnreadMessagesCount,
    this._notificationDeviceService,
    this._sessionStreamRegistry,
  ) : super(const CustomerProfileState());

  final AuthenticationRepository _authenticationRepository;
  final UserProfileUseCase _userRepository;
  final WatchUnreadMessagesCountUseCase _watchUnreadMessagesCount;
  final GetUnreadMessagesCountUseCase _getUnreadMessagesCount;
  final NotificationDeviceService _notificationDeviceService;
  final SessionStreamRegistry _sessionStreamRegistry;
  StreamSubscription<Result<int>>? _unreadMessagesSubscription;
  StreamSubscription<Map<String, String>>? _foregroundMessageSubscription;
  bool _isObservingLifecycle = false;

  Future<void> load() async {
    final user = await _userRepository.getCurrentUser();
    emit(CustomerProfileState(user: user));
    await _unreadMessagesSubscription?.cancel();
    _sessionStreamRegistry.unregister(_unreadMessagesSubscription);
    _unreadMessagesSubscription = _watchUnreadMessagesCount.execute().listen(
      (result) {
        if (isClosed) return;
        switch (result) {
          case Success(:final value):
            emit(
              CustomerProfileState(
                user: state.user,
                unreadMessagesCount: value,
              ),
            );
          case FailureResult():
            log(
              'Could not refresh unread messages.',
              name: 'CustomerProfileCubit',
            );
        }
      },
      onError: (Object error, StackTrace stackTrace) {
        log(
          'Could not watch unread messages.',
          name: 'CustomerProfileCubit',
          error: error,
          stackTrace: stackTrace,
        );
      },
    );
    _sessionStreamRegistry.register(_unreadMessagesSubscription!);
    _foregroundMessageSubscription ??= _notificationDeviceService
        .onForegroundMessage
        .where((data) => data['type'] == 'chat_message')
        .listen((_) => unawaited(_refreshUnreadMessagesCount()));
    if (!_isObservingLifecycle) {
      WidgetsBinding.instance.addObserver(this);
      _isObservingLifecycle = true;
    }
  }

  Future<void> refreshProfile() async {
    final user = await _userRepository.getCurrentUser();
    if (!isClosed) {
      emit(
        CustomerProfileState(
          user: user,
          unreadMessagesCount: state.unreadMessagesCount,
        ),
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(_refreshUnreadMessagesCount());
    }
  }

  Future<void> _refreshUnreadMessagesCount() async {
    final result = await _getUnreadMessagesCount.execute();
    if (!isClosed && result is Success<int>) {
      emit(
        CustomerProfileState(
          user: state.user,
          unreadMessagesCount: result.value,
        ),
      );
    }
  }

  Future<void> signOut() async {
    if (state.isLoading) {
      return;
    }

    emit(const CustomerProfileState(isLoading: true));
    try {
      await _authenticationRepository.signOut();
      if (!isClosed) {
        emit(const CustomerProfileState(isSignedOut: true));
      }
    } on AuthenticationException catch (error) {
      if (!isClosed) {
        emit(CustomerProfileState(errorMessage: error.message));
      }
    }
  }

  @override
  Future<void> close() async {
    if (_isObservingLifecycle) {
      WidgetsBinding.instance.removeObserver(this);
    }
    _sessionStreamRegistry.unregister(_unreadMessagesSubscription);
    await _unreadMessagesSubscription?.cancel();
    await _foregroundMessageSubscription?.cancel();
    return super.close();
  }
}
