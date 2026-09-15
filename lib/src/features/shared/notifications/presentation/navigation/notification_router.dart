import 'package:go_router/go_router.dart';
import 'package:multibook/src/features/shared/chat/domain/models/chat_conversation_arguments.dart';
import 'package:multibook/src/features/shared/notifications/domain/notification_navigation.dart';
import 'package:multibook/src/router/app_routes.dart';

class NotificationRouter implements NotificationNavigation {
  NotificationRouter(this._router);

  final GoRouter _router;

  @override
  void open(Map<String, String> data) {
    switch (data['type']) {
      case 'chat_message':
        _openChat(data);
    }
  }

  void _openChat(Map<String, String> data) {
    final businessId = data['businessId'];
    final businessOwnerId = data['businessOwnerId'];
    final businessName = data['businessName'];
    final customerId = data['customerId'];
    final customerName = data['customerName'];
    if ([
      businessId,
      businessOwnerId,
      businessName,
      customerId,
      customerName,
    ].any((value) => value == null || value.isEmpty)) {
      return;
    }

    _router.push(
      AppRoutes.CHAT_CONVERSATION,
      extra: ChatConversationArguments(
        businessId: businessId!,
        businessOwnerId: businessOwnerId!,
        businessName: businessName!,
        businessImageUrl: data['businessImageUrl'] ?? '',
        customerId: customerId!,
        customerName: customerName!,
        customerImageUrl: data['customerImageUrl'],
      ),
    );
  }
}
