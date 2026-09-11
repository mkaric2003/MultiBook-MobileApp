import 'package:dart_mappable/dart_mappable.dart';

part 'chat_conversation_model.mapper.dart';

@MappableClass()
class ChatConversationModel with ChatConversationModelMappable {
  const ChatConversationModel({
    required this.id,
    this.businessId,
    this.legacyBusinessId,
    required this.businessOwnerId,
    required this.businessName,
    this.businessImageUrl,
    required this.customerId,
    required this.customerName,
    required this.customerImageUrl,
    required this.participantIds,
    required this.activeParticipantIds,
    required this.createdAt,
    required this.updatedAt,
    this.lastMessageId,
    this.lastMessageText = '',
    this.lastMessageAt,
    this.lastSenderId,
    this.typingUserId,
    this.typingExpiresAt,
    this.lastReadAtCustomer,
    this.lastReadAtBusiness,
    this.unreadCustomerCount = 0,
    this.unreadBusinessCount = 0,
  });

  final String id;
  final String? businessId;
  final String? legacyBusinessId;
  final String businessOwnerId;
  final String businessName;
  final String? businessImageUrl;
  final String customerId;
  final String customerName;
  final String? customerImageUrl;
  final List<String> participantIds;
  final List<String> activeParticipantIds;
  final String? lastMessageId;
  final String lastMessageText;
  final DateTime? lastMessageAt;
  final String? lastSenderId;
  final String? typingUserId;
  final DateTime? typingExpiresAt;
  final DateTime? lastReadAtCustomer;
  final DateTime? lastReadAtBusiness;
  final int unreadCustomerCount;
  final int unreadBusinessCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get businessReferenceId => businessId ?? legacyBusinessId ?? '';
}
