import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/chat_conversation_model.dart';
import 'package:multibook/src/domain/use_cases/chat/get_or_create_chat_conversation_use_case.dart';
import 'package:multibook/src/domain/use_cases/chat/mark_chat_as_read_use_case.dart';
import 'package:multibook/src/domain/use_cases/chat/send_chat_message_use_case.dart';
import 'package:multibook/src/domain/use_cases/chat/set_chat_presence_use_case.dart';
import 'package:multibook/src/domain/use_cases/chat/set_chat_typing_use_case.dart';
import 'package:multibook/src/domain/use_cases/chat/watch_chat_conversation_use_case.dart';
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart';
import 'package:multibook/src/features/shared/chat/cubit/chat_conversation_state.dart';
import 'package:multibook/src/features/shared/chat/domain/models/chat_conversation_arguments.dart';
import 'package:multibook/src/features/shared/chat/domain/models/chat_conversation_snapshot.dart';

@injectable
class ChatConversationCubit extends Cubit<ChatConversationState>
    with WidgetsBindingObserver {
  ChatConversationCubit(
    this._getOrCreateConversation,
    this._watchConversation,
    this._sendMessage,
    this._markAsRead,
    this._setTyping,
    this._setPresence,
    this._userProfile,
  ) : super(const ChatConversationState());

  final GetOrCreateChatConversationUseCase _getOrCreateConversation;
  final WatchChatConversationUseCase _watchConversation;
  final SendChatMessageUseCase _sendMessage;
  final MarkChatAsReadUseCase _markAsRead;
  final SetChatTypingUseCase _setTyping;
  final SetChatPresenceUseCase _setPresence;
  final UserProfileUseCase _userProfile;
  StreamSubscription<Result<ChatConversationSnapshot>>?
  _conversationSubscription;
  Timer? _typingDebounce;
  Timer? _activeViewerHeartbeat;
  bool _isTyping = false;
  DateTime? _lastTypingUpdate;

  Future<void> open(ChatConversationArguments arguments) async {
    try {
      final currentUser = await _userProfile.getCurrentUser();
      if (currentUser == null) {
        emit(
          const ChatConversationState(
            isLoading: false,
            errorMessage: 'You need to sign in to open this conversation.',
          ),
        );
        return;
      }
      final result = await _getOrCreateConversation.execute(
        businessId: arguments.businessId,
        customerId: arguments.customerId,
      );
      switch (result) {
        case FailureResult():
          emit(
            const ChatConversationState(
              isLoading: false,
              errorMessage:
                  'We could not open this conversation. Please try again.',
            ),
          );
          return;
        case Success(:final value):
          emit(
            ChatConversationState(
              currentUserId: currentUser.id,
              conversation: value,
            ),
          );
          WidgetsBinding.instance.addObserver(this);
          await _conversationSubscription?.cancel();
          _conversationSubscription = _watchConversation
              .execute(value.id)
              .listen(_onConversationResult);
          await _updateActiveViewer(true);
          _activeViewerHeartbeat = Timer.periodic(
            const Duration(seconds: 20),
            (_) => unawaited(_updateActiveViewer(true)),
          );
          await _markAsReadIfNeeded(
            conversation: value,
            currentUserId: currentUser.id,
          );
      }
    } catch (error, stackTrace) {
      log(
        'Unexpected error while opening chat.',
        name: 'ChatConversationCubit',
        error: error,
        stackTrace: stackTrace,
      );
      emit(
        const ChatConversationState(
          isLoading: false,
          errorMessage:
              'We could not open this conversation. Please try again.',
        ),
      );
    }
  }

  void _onConversationResult(Result<ChatConversationSnapshot> result) {
    if (isClosed) return;
    switch (result) {
      case Success(:final value):
        emit(
          state.copyWith(
            isLoading: false,
            conversation: value.conversation,
            messages: value.messages,
            clearError: true,
          ),
        );
        unawaited(
          _markAsReadIfNeeded(
            conversation: value.conversation,
            currentUserId: state.currentUserId,
          ),
        );
      case FailureResult():
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'We could not load messages. Please try again.',
          ),
        );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        unawaited(_updateActiveViewer(true));
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        unawaited(_updateActiveViewer(false));
    }
  }

  Future<void> _updateActiveViewer(bool active) async {
    final conversation = state.conversation;
    if (conversation == null) return;
    final result = await _setPresence.execute(
      conversationId: conversation.id,
      active: active,
    );
    if (result is FailureResult<void>) {
      log(
        'Could not update active chat state for ${conversation.id}.',
        name: 'ChatConversationCubit',
      );
    }
  }

  Future<void> send(String text) async {
    final conversation = state.conversation;
    final trimmedText = text.trim();
    if (conversation == null || trimmedText.isEmpty || state.isSending) return;
    _typingDebounce?.cancel();
    await _updateTyping(false);
    emit(state.copyWith(isSending: true, clearError: true));
    final result = await _sendMessage.execute(
      conversationId: conversation.id,
      text: trimmedText,
    );
    if (isClosed) return;
    switch (result) {
      case Success(:final value):
        final messages = state.messages.any((message) => message.id == value.id)
            ? state.messages
            : [value, ...state.messages];
        emit(state.copyWith(isSending: false, messages: messages));
      case FailureResult():
        emit(
          state.copyWith(
            isSending: false,
            errorMessage: 'We could not send your message. Please try again.',
          ),
        );
    }
  }

  void onComposerChanged(String value) {
    _typingDebounce?.cancel();
    if (value.trim().isEmpty) {
      unawaited(_updateTyping(false));
      return;
    }
    final shouldRefreshTyping =
        _lastTypingUpdate == null ||
        DateTime.now().difference(_lastTypingUpdate!) >=
            const Duration(seconds: 2);
    if (shouldRefreshTyping) unawaited(_updateTyping(true, force: true));
    _typingDebounce = Timer(
      const Duration(seconds: 2),
      () => unawaited(_updateTyping(false)),
    );
  }

  Future<void> _updateTyping(bool active, {bool force = false}) async {
    final conversation = state.conversation;
    if (conversation == null || (!force && _isTyping == active)) return;
    _isTyping = active;
    _lastTypingUpdate = DateTime.now();
    final result = await _setTyping.execute(
      conversationId: conversation.id,
      active: active,
    );
    if (result is FailureResult<void>) {
      _isTyping = false;
      log(
        'Could not update typing status for ${conversation.id}.',
        name: 'ChatConversationCubit',
      );
    }
  }

  Future<void> _markAsReadIfNeeded({
    required ChatConversationModel conversation,
    required String currentUserId,
  }) async {
    final hasUnreadMessages = currentUserId == conversation.customerId
        ? conversation.unreadCustomerCount > 0
        : conversation.unreadBusinessCount > 0;
    if (!hasUnreadMessages) return;
    final result = await _markAsRead.execute(conversation.id);
    if (result is FailureResult<void>) {
      log(
        'Could not mark chat ${conversation.id} as read.',
        name: 'ChatConversationCubit',
      );
    }
  }

  @override
  Future<void> close() async {
    WidgetsBinding.instance.removeObserver(this);
    _activeViewerHeartbeat?.cancel();
    await _updateActiveViewer(false);
    _typingDebounce?.cancel();
    await _updateTyping(false);
    await _conversationSubscription?.cancel();
    return super.close();
  }
}
