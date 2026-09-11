import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/chat_conversation_model.dart';
import 'package:multibook/src/data/models/chat_message_model.dart';
import 'package:multibook/src/features/shared/chat/domain/models/chat_conversation_snapshot.dart';

abstract class ChatRepository {
  Stream<Result<List<ChatConversationModel>>> watchConversations();

  Stream<Result<int>> watchUnreadMessagesCount();

  Future<Result<int>> getUnreadMessagesCount();

  Future<Result<ChatConversationModel>> getOrCreateConversation({
    required String businessId,
    String? customerId,
  });

  Stream<Result<ChatConversationSnapshot>> watchConversation(
    String conversationId,
  );

  Future<Result<ChatMessageModel>> sendMessage({
    required String conversationId,
    required String text,
  });

  Future<Result<void>> markAsRead(String conversationId);

  Future<Result<void>> setTyping({
    required String conversationId,
    required bool active,
  });

  Future<Result<void>> setPresence({
    required String conversationId,
    required bool active,
  });
}
