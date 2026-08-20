import 'dart:async';

import 'package:aquabook/src/data/repositories/chat_repository.dart';
import 'package:aquabook/src/features/shared/chat/cubit/chat_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatListCubit extends Cubit<ChatListState> {
  ChatListCubit(this._repository) : super(const ChatListState());

  final ChatRepository _repository;
  StreamSubscription? _subscription;

  Future<void> load() async {
    await _subscription?.cancel();
    try {
      _subscription = _repository.watchConversations().listen(
        (conversations) =>
            emit(ChatListState(isLoading: false, conversations: conversations)),
        onError: (_, __) => emit(
          const ChatListState(
            isLoading: false,
            errorMessage: 'We could not load your messages. Please try again.',
          ),
        ),
      );
    } on ChatException catch (error) {
      emit(ChatListState(isLoading: false, errorMessage: error.message));
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
