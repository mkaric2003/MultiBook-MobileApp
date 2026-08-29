import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/data/models/chat_conversation_model.dart';

class ChatConversationArguments {
  const ChatConversationArguments({
    required this.businessId,
    required this.businessOwnerId,
    required this.businessName,
    required this.businessImageUrl,
    this.customerId,
    this.customerName,
    this.customerImageUrl,
  });

  factory ChatConversationArguments.fromBusiness(BusinessModel business) =>
      ChatConversationArguments(
        businessId: business.id,
        businessOwnerId: business.ownerId,
        businessName: business.name,
        businessImageUrl: business.coverPhotoUrl ?? business.logoUrl ?? '',
      );

  factory ChatConversationArguments.fromConversation(
    ChatConversationModel conversation,
  ) => ChatConversationArguments(
    businessId: conversation.businessId,
    businessOwnerId: conversation.businessOwnerId,
    businessName: conversation.businessName,
    businessImageUrl: conversation.businessImageUrl,
    customerId: conversation.customerId,
    customerName: conversation.customerName,
    customerImageUrl: conversation.customerImageUrl,
  );

  final String businessId;
  final String businessOwnerId;
  final String businessName;
  final String businessImageUrl;
  final String? customerId;
  final String? customerName;
  final String? customerImageUrl;
}
