import 'package:multibook/src/data/models/chat_conversation_model.dart';
import 'package:multibook/src/data/models/chat_message_model.dart';

class ChatConversationState {
  const ChatConversationState({
    this.isLoading = true,
    this.isSending = false,
    this.currentUserId = '',
    this.conversation,
    this.messages = const [],
    this.errorMessage,
  });

  final bool isLoading;
  final bool isSending;
  final String currentUserId;
  final ChatConversationModel? conversation;
  final List<ChatMessageModel> messages;
  final String? errorMessage;

  ChatConversationState copyWith({
    bool? isLoading,
    bool? isSending,
    String? currentUserId,
    ChatConversationModel? conversation,
    List<ChatMessageModel>? messages,
    String? errorMessage,
    bool clearError = false,
  }) => ChatConversationState(
    isLoading: isLoading ?? this.isLoading,
    isSending: isSending ?? this.isSending,
    currentUserId: currentUserId ?? this.currentUserId,
    conversation: conversation ?? this.conversation,
    messages: messages ?? this.messages,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );
}
