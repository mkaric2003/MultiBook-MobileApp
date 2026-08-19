import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageModel {
  const ChatMessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.text,
    this.createdAt,
  });

  final String id;
  final String conversationId;
  final String senderId;
  final String text;
  final DateTime? createdAt;

  factory ChatMessageModel.fromMap(Map<String, dynamic> data) {
    final createdAt = data['createdAt'];
    return ChatMessageModel(
      id: data['id'] as String? ?? '',
      conversationId: data['conversationId'] as String? ?? '',
      senderId: data['senderId'] as String? ?? '',
      text: data['text'] as String? ?? '',
      createdAt: createdAt is Timestamp ? createdAt.toDate() : null,
    );
  }
}
