import 'dart:async';
import 'dart:developer';

import 'package:multibook/src/data/repositories/authentication_repository.dart';
import 'package:multibook/src/core/session/session_stream_registry.dart';
import 'package:multibook/src/data/repositories/chat_repository.dart';
import 'package:multibook/src/data/repositories/user_repository.dart';
import 'package:multibook/src/features/customer-side/profile/cubit/customer_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CustomerProfileCubit extends Cubit<CustomerProfileState> {
  CustomerProfileCubit(
    this._authenticationRepository,
    this._userRepository,
    this._chatRepository,
    this._sessionStreamRegistry,
  ) : super(const CustomerProfileState());

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final ChatRepository _chatRepository;
  final SessionStreamRegistry _sessionStreamRegistry;
  StreamSubscription<int>? _unreadMessagesSubscription;

  Future<void> load() async {
    final user = await _userRepository.getCurrentUser();
    emit(CustomerProfileState(user: user));
    await _chatRepository.ensureUnreadMessagesCount();
    await _unreadMessagesSubscription?.cancel();
    _sessionStreamRegistry.unregister(_unreadMessagesSubscription);
    _unreadMessagesSubscription = _chatRepository
        .watchUnreadMessagesCount()
        .listen(
          (count) {
            if (!isClosed) {
              emit(
                CustomerProfileState(
                  user: state.user,
                  unreadMessagesCount: count,
                ),
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
    _sessionStreamRegistry.unregister(_unreadMessagesSubscription);
    await _unreadMessagesSubscription?.cancel();
    return super.close();
  }
}
