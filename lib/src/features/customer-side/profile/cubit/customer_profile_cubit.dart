import 'dart:async';

import 'package:aquabook/src/data/repositories/authentication_repository.dart';
import 'package:aquabook/src/data/repositories/chat_repository.dart';
import 'package:aquabook/src/data/repositories/user_repository.dart';
import 'package:aquabook/src/features/customer-side/profile/cubit/customer_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CustomerProfileCubit extends Cubit<CustomerProfileState> {
  CustomerProfileCubit(
    this._authenticationRepository,
    this._userRepository,
    this._chatRepository,
  ) : super(const CustomerProfileState());

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final ChatRepository _chatRepository;
  StreamSubscription<int>? _unreadMessagesSubscription;

  Future<void> load() async {
    final user = await _userRepository.getCurrentUser();
    emit(CustomerProfileState(user: user));
    await _chatRepository.ensureUnreadMessagesCount();
    await _unreadMessagesSubscription?.cancel();
    _unreadMessagesSubscription = _chatRepository
        .watchUnreadMessagesCount()
        .listen(
          (count) => emit(
            CustomerProfileState(user: state.user, unreadMessagesCount: count),
          ),
        );
  }

  Future<void> signOut() async {
    if (state.isLoading) {
      return;
    }

    emit(const CustomerProfileState(isLoading: true));
    try {
      await _authenticationRepository.signOut();
      emit(const CustomerProfileState(isSignedOut: true));
    } on AuthenticationException catch (error) {
      emit(CustomerProfileState(errorMessage: error.message));
    }
  }

  @override
  Future<void> close() async {
    await _unreadMessagesSubscription?.cancel();
    return super.close();
  }
}
