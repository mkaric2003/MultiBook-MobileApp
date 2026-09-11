import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/api_exception.dart';
import 'package:multibook/src/core/errors/rest_repository_executor.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/data_sources/chat_api_data_source.dart';
import 'package:multibook/src/data/data_sources/firebase_storage_data_source.dart';
import 'package:multibook/src/data/models/chat_conversation_model.dart';
import 'package:multibook/src/data/models/chat_message_model.dart';
import 'package:multibook/src/domain/repositories/chat_repository.dart';
import 'package:multibook/src/features/shared/chat/domain/models/chat_conversation_snapshot.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._source, this._storage, this._executor);

  final ChatApiDataSource _source;
  final FirebaseStorageDataSource _storage;
  final RestRepositoryExecutor _executor;
  final Uuid _uuid = const Uuid();
  final Map<String, String> _resolvedImageUrls = {};

  @override
  Stream<Result<List<ChatConversationModel>>> watchConversations() async* {
    yield await _loadConversations();
    try {
      await for (final _ in _source.watchInvalidations()) {
        yield await _loadConversations();
      }
    } on ApiException catch (error) {
      yield FailureResult(_executor.mapFailure(error));
    } catch (error, stackTrace) {
      log(
        'Chat conversation stream failed.',
        name: 'ChatRepositoryImpl',
        error: error,
        stackTrace: stackTrace,
      );
      yield const FailureResult(UnknownFailure());
    }
  }

  @override
  Stream<Result<int>> watchUnreadMessagesCount() async* {
    yield await getUnreadMessagesCount();
    try {
      await for (final _ in _source.watchInvalidations()) {
        yield await getUnreadMessagesCount();
      }
    } on ApiException catch (error) {
      yield FailureResult(_executor.mapFailure(error));
    } catch (error, stackTrace) {
      log(
        'Chat unread stream failed.',
        name: 'ChatRepositoryImpl',
        error: error,
        stackTrace: stackTrace,
      );
      yield const FailureResult(UnknownFailure());
    }
  }

  @override
  Future<Result<int>> getUnreadMessagesCount() =>
      _executor.execute(_source.getUnreadCount);

  @override
  Future<Result<ChatConversationModel>> getOrCreateConversation({
    required String businessId,
    String? customerId,
  }) => _executor.execute(() async {
    final conversation = await _source.getOrCreateConversation(
      businessId: businessId,
      customerId: customerId,
    );
    return _resolveImages(conversation);
  });

  @override
  Stream<Result<ChatConversationSnapshot>> watchConversation(
    String conversationId,
  ) async* {
    ChatConversationSnapshot? snapshot;
    var result = await _loadSnapshot(conversationId, snapshot);
    if (result case Success(:final value)) snapshot = value;
    yield result;
    try {
      await for (final changedConversationId in _source.watchInvalidations()) {
        if (changedConversationId != null &&
            changedConversationId != conversationId) {
          continue;
        }
        result = await _loadSnapshot(conversationId, snapshot);
        if (result case Success(:final value)) snapshot = value;
        yield result;
      }
    } on ApiException catch (error) {
      yield FailureResult(_executor.mapFailure(error));
    } catch (error, stackTrace) {
      log(
        'Chat detail stream failed for $conversationId.',
        name: 'ChatRepositoryImpl',
        error: error,
        stackTrace: stackTrace,
      );
      yield const FailureResult(UnknownFailure());
    }
  }

  @override
  Future<Result<ChatMessageModel>> sendMessage({
    required String conversationId,
    required String text,
  }) => _executor.execute(
    () => _source.sendMessage(
      conversationId: conversationId,
      messageId: _uuid.v4(),
      text: text.trim(),
    ),
  );

  @override
  Future<Result<void>> markAsRead(String conversationId) =>
      _executor.execute(() => _source.markAsRead(conversationId));

  @override
  Future<Result<void>> setTyping({
    required String conversationId,
    required bool active,
  }) => _executor.execute(() => _source.setTyping(conversationId, active));

  @override
  Future<Result<void>> setPresence({
    required String conversationId,
    required bool active,
  }) => _executor.execute(() => _source.setPresence(conversationId, active));

  Future<Result<List<ChatConversationModel>>> _loadConversations() =>
      _executor.execute(() async {
        final page = await _source.listConversations();
        return Future.wait(page.items.map(_resolveImages));
      });

  Future<Result<ChatConversationSnapshot>> _loadSnapshot(
    String conversationId,
    ChatConversationSnapshot? previous,
  ) => _executor.execute(() async {
    final conversation = await _resolveImages(
      await _source.getConversation(conversationId),
    );
    final shouldReloadMessages =
        previous == null ||
        previous.conversation.lastMessageId != conversation.lastMessageId;
    final messages = shouldReloadMessages
        ? (await _source.listMessages(conversationId)).items
        : previous.messages;
    return ChatConversationSnapshot(
      conversation: conversation,
      messages: messages,
    );
  });

  Future<ChatConversationModel> _resolveImages(
    ChatConversationModel conversation,
  ) async {
    final businessImage = await _resolveImage(
      conversation.businessImageUrl ?? '',
    );
    final customerImage = conversation.customerImageUrl == null
        ? null
        : await _resolveImage(conversation.customerImageUrl!);
    return conversation.copyWith(
      businessImageUrl: businessImage,
      customerImageUrl: customerImage,
    );
  }

  Future<String> _resolveImage(String path) async {
    if (path.isEmpty) return '';
    final cachedUrl = _resolvedImageUrls[path];
    if (cachedUrl != null) return cachedUrl;
    try {
      final url = await _storage.getDownloadUrl(storagePath: path);
      _resolvedImageUrls[path] = url;
      return url;
    } catch (error, stackTrace) {
      log(
        'Could not resolve chat image path.',
        name: 'ChatRepositoryImpl',
        error: error,
        stackTrace: stackTrace,
      );
      return '';
    }
  }
}
