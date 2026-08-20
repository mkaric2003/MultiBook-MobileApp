import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/models/chat_conversation_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatConversationTile extends StatelessWidget {
  const ChatConversationTile({
    required this.conversation,
    required this.currentUserId,
    required this.onTap,
    super.key,
  });

  final ChatConversationModel conversation;
  final String currentUserId;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isCustomer = currentUserId == conversation.customerId;
    final title = isCustomer
        ? conversation.businessName
        : conversation.customerName;
    final imageUrl = isCustomer
        ? conversation.businessImageUrl
        : conversation.customerImageUrl ?? '';
    final unreadCount = isCustomer
        ? conversation.unreadCustomerCount
        : conversation.unreadBusinessCount;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.surfaceHighlight,
              backgroundImage: imageUrl.isEmpty ? null : NetworkImage(imageUrl),
              child: imageUrl.isEmpty
                  ? Icon(
                      isCustomer
                          ? Icons.storefront_rounded
                          : Icons.person_rounded,
                      color: AppColors.primary,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    isCustomer ? conversation.businessName : 'Customer',
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    conversation.lastMessageText.isEmpty
                        ? 'Start a conversation'
                        : conversation.lastMessageText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (conversation.lastMessageAt != null)
                  Text(
                    DateFormat('MMM d').format(conversation.lastMessageAt!),
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 11,
                    ),
                  ),
                const SizedBox(height: 8),
                if (unreadCount > 0)
                  Container(
                    constraints: const BoxConstraints(minWidth: 20),
                    height: 20,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$unreadCount',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
