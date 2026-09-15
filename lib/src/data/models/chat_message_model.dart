import 'package:dart_mappable/dart_mappable.dart';

part 'chat_message_model.mapper.dart';

@MappableClass()
class ChatMessageModel with ChatMessageModelMappable {
  const ChatMessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.text,
    required this.createdAt,
  });

  final String id;
  final String conversationId;
  final String senderId;
  final String text;
  final DateTime createdAt;
}
