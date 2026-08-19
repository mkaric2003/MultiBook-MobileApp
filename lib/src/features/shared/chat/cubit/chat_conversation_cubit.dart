import 'dart:async';
import 'dart:developer';

import 'package:aquabook/src/data/models/chat_conversation_model.dart';
import 'package:aquabook/src/data/repositories/chat_repository.dart';
import 'package:aquabook/src/data/repositories/user_repository.dart';
import 'package:aquabook/src/features/shared/chat/cubit/chat_conversation_state.dart';
import 'package:aquabook/src/features/shared/chat/domain/models/chat_conversation_arguments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatConversationCubit extends Cubit<ChatConversationState> {
  ChatConversationCubit(this._chatRepository, this._userRepository)
    : super(const ChatConversationState());

  final ChatRepository _chatRepository;
  final UserRepository _userRepository;
  StreamSubscription? _messagesSubscription;
  StreamSubscription? _conversationSubscription;
  Timer? _typingDebounce;
  bool _isTyping = false;
  DateTime? _lastTypingUpdate;

  Future<void> open(ChatConversationArguments arguments) async {
    try {
      final currentUser = await _userRepository.getCurrentUser();
      if (currentUser == null) {
        log('No current user found.', name: 'ChatConversationCubit');
        emit(
          const ChatConversationState(
            isLoading: false,
            errorMessage: 'You need to sign in to open this conversation.',
          ),
        );
        return;
      }
      final customerId = arguments.customerId ?? currentUser.id;
      final customerName = arguments.customerName ?? currentUser.fullName;
      final customerImageUrl =
          arguments.customerImageUrl ?? currentUser.profileImageUrl;
      final conversation = await _chatRepository.getOrCreateConversation(
        businessId: arguments.businessId,
        businessOwnerId: arguments.businessOwnerId,
        businessName: arguments.businessName,
        businessImageUrl: arguments.businessImageUrl,
        customerId: customerId,
        customerName: customerName,
        customerImageUrl: customerImageUrl,
      );
      emit(
        ChatConversationState(
          isLoading: false,
          currentUserId: currentUser.id,
          conversation: conversation,
        ),
      );
      await _messagesSubscription?.cancel();
      await _conversationSubscription?.cancel();
      _messagesSubscription = _chatRepository
          .watchMessages(conversation.id)
          .listen(
            (messages) => emit(state.copyWith(messages: messages)),
            onError: (_, __) => emit(
              state.copyWith(
                errorMessage: 'We could not load messages. Please try again.',
              ),
            ),
          );
      _conversationSubscription = _chatRepository
          .watchConversation(conversation.id)
          .listen((updatedConversation) {
            if (updatedConversation == null) return;
            emit(state.copyWith(conversation: updatedConversation));
            _markAsReadIfNeeded(
              conversation: updatedConversation,
              currentUserId: currentUser.id,
            );
          });
      await _markAsReadIfNeeded(
        conversation: conversation,
        currentUserId: currentUser.id,
      );
    } on ChatException catch (error, stackTrace) {
      log(
        'Chat open failed: ${error.message}',
        name: 'ChatConversationCubit',
        error: error,
        stackTrace: stackTrace,
      );
      emit(
        ChatConversationState(isLoading: false, errorMessage: error.message),
      );
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

  Future<void> send(String text) async {
    final conversation = state.conversation;
    if (conversation == null || text.trim().isEmpty || state.isSending) return;
    _typingDebounce?.cancel();
    await _updateTyping(false);
    emit(state.copyWith(isSending: true, clearError: true));
    try {
      await _chatRepository.sendMessage(
        conversationId: conversation.id,
        text: text,
      );
      if (!isClosed) {
        emit(state.copyWith(isSending: false));
      }
    } on ChatException catch (error) {
      if (!isClosed) {
        emit(state.copyWith(isSending: false, errorMessage: error.message));
      }
    } catch (_) {
      if (!isClosed) {
        emit(
          state.copyWith(
            isSending: false,
            errorMessage: 'We could not send your message. Please try again.',
          ),
        );
      }
    }
  }

  void onComposerChanged(String value) {
    _typingDebounce?.cancel();
    if (value.trim().isEmpty) {
      _updateTyping(false);
      return;
    }
    final shouldRefreshTyping =
        _lastTypingUpdate == null ||
        DateTime.now().difference(_lastTypingUpdate!) >=
            const Duration(seconds: 2);
    if (shouldRefreshTyping) _updateTyping(true, force: true);
    _typingDebounce = Timer(
      const Duration(seconds: 2),
      () => _updateTyping(false),
    );
  }

  Future<void> _updateTyping(bool isTyping, {bool force = false}) async {
    final conversation = state.conversation;
    if (conversation == null || (!force && _isTyping == isTyping)) return;
    _isTyping = isTyping;
    _lastTypingUpdate = DateTime.now();
    try {
      await _chatRepository.setTyping(
        conversationId: conversation.id,
        isTyping: isTyping,
      );
    } catch (error, stackTrace) {
      _isTyping = false;
      log(
        'Could not update typing status for ${conversation.id}.',
        name: 'ChatConversationCubit',
        error: error,
        stackTrace: stackTrace,
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
    await _chatRepository.markAsRead(conversation);
  }

  @override
  Future<void> close() async {
    _typingDebounce?.cancel();
    await _updateTyping(false);
    await _messagesSubscription?.cancel();
    await _conversationSubscription?.cancel();
    return super.close();
  }
}
