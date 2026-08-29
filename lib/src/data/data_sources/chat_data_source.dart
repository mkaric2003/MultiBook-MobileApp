import 'package:multibook/src/data/models/chat_conversation_model.dart';
import 'package:multibook/src/data/models/chat_message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

abstract class ChatDataSource {
  Future<ChatConversationModel> getOrCreateConversation(
    ChatConversationModel conversation,
  );

  Stream<List<ChatConversationModel>> watchConversations(String userId);
  Stream<int> watchUnreadMessagesCount(String userId);
  Future<void> ensureUnreadMessagesCount(String userId);
  Stream<List<ChatMessageModel>> watchMessages(String conversationId);
  Stream<ChatConversationModel?> watchConversation(String conversationId);
  Future<void> sendMessage({
    required String conversationId,
    required String senderId,
    required String text,
  });
  Future<void> markAsRead({
    required String conversationId,
    required String userId,
    required bool isCustomer,
  });
  Future<void> setTyping({
    required String conversationId,
    required String userId,
    required bool isTyping,
  });
  Future<void> setActiveViewer({
    required String conversationId,
    required String userId,
    required bool isActive,
  });
}

@LazySingleton(as: ChatDataSource)
class ChatDataSourceImpl implements ChatDataSource {
  ChatDataSourceImpl(this._firestore);

  static const _conversations = 'conversations';
  final FirebaseFirestore _firestore;

  @override
  Future<ChatConversationModel> getOrCreateConversation(
    ChatConversationModel conversation,
  ) async {
    final reference = _firestore
        .collection(_conversations)
        .doc(conversation.id);
    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(reference);
      if (!snapshot.exists) {
        transaction.set(reference, {
          ...conversation.toMap(),
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    });
    final snapshot = await reference.get();
    if (!snapshot.exists || snapshot.data() == null) {
      throw StateError('Conversation was not found after creation.');
    }
    return ChatConversationModel.fromMap(snapshot.data()!);
  }

  @override
  Stream<List<ChatConversationModel>> watchConversations(String userId) =>
      _firestore
          .collection(_conversations)
          .where('participantIds', arrayContains: userId)
          .orderBy('lastMessageAt', descending: true)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map(
                  (document) => ChatConversationModel.fromMap(document.data()),
                )
                .toList(),
          );

  @override
  Stream<int> watchUnreadMessagesCount(String userId) => _firestore
      .collection('users')
      .doc(userId)
      .snapshots()
      .map(
        (snapshot) =>
            (snapshot.data()?['unreadMessagesCount'] as num?)?.toInt() ?? 0,
      );

  @override
  Future<void> ensureUnreadMessagesCount(String userId) async {
    final userReference = _firestore.collection('users').doc(userId);
    final conversations = await _firestore
        .collection(_conversations)
        .where('participantIds', arrayContains: userId)
        .get();
    final unreadCount = conversations.docs.fold<int>(0, (total, document) {
      final data = document.data();
      final isCustomer = data['customerId'] == userId;
      final count = isCustomer
          ? (data['unreadCustomerCount'] as num?)?.toInt() ?? 0
          : (data['unreadBusinessCount'] as num?)?.toInt() ?? 0;
      return total + count;
    });
    await _firestore.runTransaction((transaction) async {
      final user = await transaction.get(userReference);
      if (user.data()?.containsKey('unreadMessagesCount') ?? false) return;
      transaction.set(userReference, {
        'unreadMessagesCount': unreadCount,
      }, SetOptions(merge: true));
    });
  }

  @override
  Stream<List<ChatMessageModel>> watchMessages(String conversationId) =>
      _firestore
          .collection(_conversations)
          .doc(conversationId)
          .collection('messages')
          .orderBy('createdAt', descending: true)
          .limit(60)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((document) => ChatMessageModel.fromMap(document.data()))
                .toList(),
          );

  @override
  Stream<ChatConversationModel?> watchConversation(String conversationId) =>
      _firestore
          .collection(_conversations)
          .doc(conversationId)
          .snapshots()
          .map(
            (snapshot) => snapshot.exists
                ? ChatConversationModel.fromMap(snapshot.data()!)
                : null,
          );

  @override
  Future<void> sendMessage({
    required String conversationId,
    required String senderId,
    required String text,
  }) async {
    final conversationReference = _firestore
        .collection(_conversations)
        .doc(conversationId);
    final messageReference = conversationReference.collection('messages').doc();
    await _firestore.runTransaction((transaction) async {
      final conversation = await transaction.get(conversationReference);
      if (!conversation.exists) {
        throw StateError('Conversation no longer exists.');
      }
      final data = conversation.data()!;
      final customerId = data['customerId'] as String;
      final isCustomerSender = senderId == customerId;
      final recipientId = isCustomerSender
          ? data['businessOwnerId'] as String
          : customerId;
      final activeViewers = Map<String, dynamic>.from(
        data['activeParticipantExpiresAt'] as Map? ?? const {},
      );
      final recipientActiveUntil = activeViewers[recipientId];
      final recipientIsViewing =
          recipientActiveUntil is Timestamp &&
          recipientActiveUntil.toDate().isAfter(DateTime.now());
      transaction.set(messageReference, {
        'id': messageReference.id,
        'conversationId': conversationId,
        'senderId': senderId,
        'text': text,
        'createdAt': FieldValue.serverTimestamp(),
      });
      transaction.update(conversationReference, {
        'lastMessageText': text,
        'lastMessageAt': FieldValue.serverTimestamp(),
        'lastSenderId': senderId,
        if (!recipientIsViewing && isCustomerSender)
          'unreadBusinessCount': FieldValue.increment(1),
        if (!recipientIsViewing && !isCustomerSender)
          'unreadCustomerCount': FieldValue.increment(1),
      });
    });
  }

  @override
  Future<void> markAsRead({
    required String conversationId,
    required String userId,
    required bool isCustomer,
  }) async {
    final conversationReference = _firestore
        .collection(_conversations)
        .doc(conversationId);
    final userReference = _firestore.collection('users').doc(userId);
    await _firestore.runTransaction((transaction) async {
      final conversation = await transaction.get(conversationReference);
      if (!conversation.exists) return;
      final unreadField = isCustomer
          ? 'unreadCustomerCount'
          : 'unreadBusinessCount';
      final unreadCount =
          (conversation.data()?[unreadField] as num?)?.toInt() ?? 0;
      if (unreadCount == 0) return;
      final user = await transaction.get(userReference);
      final aggregateCount =
          (user.data()?['unreadMessagesCount'] as num?)?.toInt() ?? 0;
      transaction.update(conversationReference, {
        unreadField: 0,
        isCustomer ? 'lastReadAtCustomer' : 'lastReadAtBusiness':
            FieldValue.serverTimestamp(),
      });
      transaction.set(userReference, {
        'unreadMessagesCount': (aggregateCount - unreadCount).clamp(0, 1 << 31),
      }, SetOptions(merge: true));
    });
  }

  @override
  Future<void> setTyping({
    required String conversationId,
    required String userId,
    required bool isTyping,
  }) => _firestore.collection(_conversations).doc(conversationId).update({
    'typingUserId': isTyping ? userId : null,
    'typingExpiresAt': isTyping
        ? DateTime.now().add(const Duration(seconds: 4))
        : null,
  });

  @override
  Future<void> setActiveViewer({
    required String conversationId,
    required String userId,
    required bool isActive,
  }) async {
    final reference = _firestore.collection(_conversations).doc(conversationId);
    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(reference);
      if (!snapshot.exists) return;
      final activeViewers = Map<String, dynamic>.from(
        snapshot.data()?['activeParticipantExpiresAt'] as Map? ?? const {},
      );
      if (isActive) {
        activeViewers[userId] = Timestamp.fromDate(
          DateTime.now().add(const Duration(seconds: 45)),
        );
      } else {
        activeViewers.remove(userId);
      }
      transaction.update(reference, {
        'activeParticipantExpiresAt': activeViewers,
      });
    });
  }
}
