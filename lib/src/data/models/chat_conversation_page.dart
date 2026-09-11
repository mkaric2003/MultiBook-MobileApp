import 'package:dart_mappable/dart_mappable.dart';
import 'package:multibook/src/data/models/chat_conversation_model.dart';

part 'chat_conversation_page.mapper.dart';

@MappableClass()
class ChatConversationPage with ChatConversationPageMappable {
  const ChatConversationPage({required this.items, this.nextCursor});

  final List<ChatConversationModel> items;
  final String? nextCursor;
}
