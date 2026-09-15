import 'dart:async';

import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/chat_conversation_model.dart';
import 'package:multibook/src/domain/use_cases/chat/watch_chat_conversations_use_case.dart';
import 'package:multibook/src/features/shared/chat/cubit/chat_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatListCubit extends Cubit<ChatListState> {
  ChatListCubit(this._watchConversations) : super(const ChatListState());

  final WatchChatConversationsUseCase _watchConversations;
  StreamSubscription<Result<List<ChatConversationModel>>>? _subscription;

  Future<void> load() async {
    await _subscription?.cancel();
    _subscription = _watchConversations.execute().listen((result) {
      if (isClosed) return;
      switch (result) {
        case Success(:final value):
          emit(ChatListState(isLoading: false, conversations: value));
        case FailureResult():
          emit(
            const ChatListState(
              isLoading: false,
              errorMessage:
                  'We could not load your messages. Please try again.',
            ),
          );
      }
    });
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
