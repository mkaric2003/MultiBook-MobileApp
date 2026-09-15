import 'package:dart_mappable/dart_mappable.dart';
import 'package:multibook/src/data/models/chat_conversation_model.dart';
import 'package:multibook/src/data/models/chat_message_model.dart';

part 'chat_conversation_snapshot.mapper.dart';

@MappableClass()
class ChatConversationSnapshot with ChatConversationSnapshotMappable {
  const ChatConversationSnapshot({
    required this.conversation,
    required this.messages,
  });

  final ChatConversationModel conversation;
  final List<ChatMessageModel> messages;
}
