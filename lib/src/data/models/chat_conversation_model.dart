import 'package:cloud_firestore/cloud_firestore.dart';

class ChatConversationModel {
  const ChatConversationModel({
    required this.id,
    required this.businessId,
    required this.businessOwnerId,
    required this.businessName,
    required this.businessImageUrl,
    required this.customerId,
    required this.customerName,
    required this.customerImageUrl,
    required this.participantIds,
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
  final String businessId;
  final String businessOwnerId;
  final String businessName;
  final String businessImageUrl;
  final String customerId;
  final String customerName;
  final String? customerImageUrl;
  final List<String> participantIds;
  final String lastMessageText;
  final DateTime? lastMessageAt;
  final String? lastSenderId;
  final String? typingUserId;
  final DateTime? typingExpiresAt;
  final DateTime? lastReadAtCustomer;
  final DateTime? lastReadAtBusiness;
  final int unreadCustomerCount;
  final int unreadBusinessCount;

  factory ChatConversationModel.fromMap(Map<String, dynamic> data) {
    final lastMessageAt = data['lastMessageAt'];
    final typingExpiresAt = data['typingExpiresAt'];
    final lastReadAtCustomer = data['lastReadAtCustomer'];
    final lastReadAtBusiness = data['lastReadAtBusiness'];
    return ChatConversationModel(
      id: data['id'] as String? ?? '',
      businessId: data['businessId'] as String? ?? '',
      businessOwnerId: data['businessOwnerId'] as String? ?? '',
      businessName: data['businessName'] as String? ?? '',
      businessImageUrl: data['businessImageUrl'] as String? ?? '',
      customerId: data['customerId'] as String? ?? '',
      customerName: data['customerName'] as String? ?? '',
      customerImageUrl: data['customerImageUrl'] as String?,
      participantIds: List<String>.from(data['participantIds'] as List? ?? []),
      lastMessageText: data['lastMessageText'] as String? ?? '',
      lastMessageAt: lastMessageAt is Timestamp ? lastMessageAt.toDate() : null,
      lastSenderId: data['lastSenderId'] as String?,
      typingUserId: data['typingUserId'] as String?,
      typingExpiresAt: typingExpiresAt is Timestamp
          ? typingExpiresAt.toDate()
          : null,
      lastReadAtCustomer: lastReadAtCustomer is Timestamp
          ? lastReadAtCustomer.toDate()
          : null,
      lastReadAtBusiness: lastReadAtBusiness is Timestamp
          ? lastReadAtBusiness.toDate()
          : null,
      unreadCustomerCount: (data['unreadCustomerCount'] as num?)?.toInt() ?? 0,
      unreadBusinessCount: (data['unreadBusinessCount'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, Object?> toMap() => {
    'id': id,
    'businessId': businessId,
    'businessOwnerId': businessOwnerId,
    'businessName': businessName,
    'businessImageUrl': businessImageUrl,
    'customerId': customerId,
    'customerName': customerName,
    'customerImageUrl': customerImageUrl,
    'participantIds': participantIds,
    'lastMessageText': lastMessageText,
    'lastMessageAt': lastMessageAt,
    'lastSenderId': lastSenderId,
    'typingUserId': typingUserId,
    'typingExpiresAt': typingExpiresAt,
    'lastReadAtCustomer': lastReadAtCustomer,
    'lastReadAtBusiness': lastReadAtBusiness,
    'unreadCustomerCount': unreadCustomerCount,
    'unreadBusinessCount': unreadBusinessCount,
  };
}
