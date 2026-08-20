import 'dart:developer';

import 'package:aquabook/src/data/data_sources/authentication_data_source.dart';
import 'package:aquabook/src/data/data_sources/chat_data_source.dart';
import 'package:aquabook/src/data/models/chat_conversation_model.dart';
import 'package:aquabook/src/data/models/chat_message_model.dart';
import 'package:injectable/injectable.dart';

class ChatException implements Exception {
  const ChatException(this.message);
  final String message;
}

@lazySingleton
class ChatRepository {
  ChatRepository(this._auth, this._dataSource);

  final AuthenticationDataSource _auth;
  final ChatDataSource _dataSource;

  Stream<List<ChatConversationModel>> watchConversations() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw const ChatException('You need to sign in to view messages.');
    }
    return _dataSource.watchConversations(userId);
  }

  Stream<int> watchUnreadMessagesCount() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value(0);
    return _dataSource.watchUnreadMessagesCount(userId);
  }

  Future<void> ensureUnreadMessagesCount() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;
    await _dataSource.ensureUnreadMessagesCount(userId);
  }

  Future<ChatConversationModel> getOrCreateConversation({
    required String businessId,
    required String businessOwnerId,
    required String businessName,
    required String businessImageUrl,
    required String customerId,
    required String customerName,
    String? customerImageUrl,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null || (userId != customerId && userId != businessOwnerId)) {
      log(
        'Conversation access rejected: authenticated user is not a participant.',
        name: 'ChatRepository',
      );
      throw const ChatException(
        'You are not allowed to open this conversation.',
      );
    }
    final id = '${businessId}_$customerId';
    final conversation = await _dataSource.getOrCreateConversation(
      ChatConversationModel(
        id: id,
        businessId: businessId,
        businessOwnerId: businessOwnerId,
        businessName: businessName,
        businessImageUrl: businessImageUrl,
        customerId: customerId,
        customerName: customerName,
        customerImageUrl: customerImageUrl,
        participantIds: [customerId, businessOwnerId],
      ),
    );
    return conversation;
  }

  Stream<List<ChatMessageModel>> watchMessages(String conversationId) =>
      _dataSource.watchMessages(conversationId);

  Stream<ChatConversationModel?> watchConversation(String conversationId) =>
      _dataSource.watchConversation(conversationId);

  Future<void> sendMessage({
    required String conversationId,
    required String text,
  }) async {
    final senderId = _auth.currentUser?.uid;
    if (senderId == null) {
      throw const ChatException('You need to sign in to send a message.');
    }
    final trimmedText = text.trim();
    if (trimmedText.isEmpty) return;
    await _dataSource.sendMessage(
      conversationId: conversationId,
      senderId: senderId,
      text: trimmedText,
    );
  }

  Future<void> markAsRead(ChatConversationModel conversation) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;
    await _dataSource.markAsRead(
      conversationId: conversation.id,
      userId: userId,
      isCustomer: userId == conversation.customerId,
    );
  }

  Future<void> setTyping({
    required String conversationId,
    required bool isTyping,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;
    await _dataSource.setTyping(
      conversationId: conversationId,
      userId: userId,
      isTyping: isTyping,
    );
  }

  Future<void> setActiveViewer({
    required String conversationId,
    required bool isActive,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;
    await _dataSource.setActiveViewer(
      conversationId: conversationId,
      userId: userId,
      isActive: isActive,
    );
  }
}
