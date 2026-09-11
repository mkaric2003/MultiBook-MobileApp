import 'package:dart_mappable/dart_mappable.dart';
import 'package:multibook/src/data/models/chat_message_model.dart';

part 'chat_message_page.mapper.dart';

@MappableClass()
class ChatMessagePage with ChatMessagePageMappable {
  const ChatMessagePage({required this.items, this.nextCursor});

  final List<ChatMessageModel> items;
  final String? nextCursor;
}
