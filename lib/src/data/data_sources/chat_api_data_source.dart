import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/networking/api_client.dart';
import 'package:multibook/src/core/networking/sse_client.dart';
import 'package:multibook/src/data/models/chat_conversation_model.dart';
import 'package:multibook/src/data/models/chat_conversation_page.dart';
import 'package:multibook/src/data/models/chat_message_model.dart';
import 'package:multibook/src/data/models/chat_message_page.dart';

@lazySingleton
class ChatApiDataSource {
  ChatApiDataSource(this._client, this._sseClient);

  final ApiClient _client;
  final SseClient _sseClient;

  Future<ChatConversationModel> getOrCreateConversation({
    required String businessId,
    String? customerId,
  }) async {
    final response = await _client.post(
      '/v1/conversations',
      data: {
        'businessId': businessId,
        if (customerId != null && customerId.isNotEmpty)
          'customerId': customerId,
      },
    );
    return ChatConversationModelMapper.fromMap(response.data!);
  }

  Future<ChatConversationPage> listConversations({
    String? cursor,
    int pageSize = 60,
  }) async {
    final response = await _client.get(
      '/v1/conversations',
      queryParameters: {
        if (cursor != null) 'cursor': cursor,
        'page_size': pageSize,
      },
    );
    return ChatConversationPageMapper.fromMap(response.data!);
  }

  Future<ChatConversationModel> getConversation(String conversationId) async {
    final response = await _client.get('/v1/conversations/$conversationId');
    return ChatConversationModelMapper.fromMap(response.data!);
  }

  Future<ChatMessagePage> listMessages(
    String conversationId, {
    String? cursor,
    int pageSize = 60,
  }) async {
    final response = await _client.get(
      '/v1/conversations/$conversationId/messages',
      queryParameters: {
        if (cursor != null) 'cursor': cursor,
        'page_size': pageSize,
      },
    );
    return ChatMessagePageMapper.fromMap(response.data!);
  }

  Future<ChatMessageModel> sendMessage({
    required String conversationId,
    required String messageId,
    required String text,
  }) async {
    final response = await _client.post(
      '/v1/conversations/$conversationId/messages',
      data: {'id': messageId, 'text': text},
    );
    return ChatMessageModelMapper.fromMap(response.data!);
  }

  Future<void> markAsRead(String conversationId) =>
      _client.patch('/v1/conversations/$conversationId/read', data: const {});

  Future<void> setTyping(String conversationId, bool active) => _client.put(
    '/v1/conversations/$conversationId/typing',
    data: {'active': active},
  );

  Future<void> setPresence(String conversationId, bool active) => _client.put(
    '/v1/conversations/$conversationId/presence',
    data: {'active': active},
  );

  Future<int> getUnreadCount() async {
    final response = await _client.get('/v1/conversations/unread-count');
    return (response.data!['count'] as num?)?.toInt() ?? 0;
  }

  Stream<String?> watchInvalidations() => _sseClient.watchEvents(
    path: '/v1/chat/stream',
    eventNames: const {'chat_sync', 'chat_changed'},
    decode: (eventName, data) {
      if (eventName == 'chat_sync') return null;
      final payload = jsonDecode(data) as Map<String, dynamic>;
      return payload['conversationId'] as String?;
    },
  );
}
