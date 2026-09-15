import 'package:multibook/src/data/models/chat_conversation_model.dart';

class ChatListState {
  const ChatListState({
    this.isLoading = true,
    this.conversations = const [],
    this.errorMessage,
  });

  final bool isLoading;
  final List<ChatConversationModel> conversations;
  final String? errorMessage;
}
