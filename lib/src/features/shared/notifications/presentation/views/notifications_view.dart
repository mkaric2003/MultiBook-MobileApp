import 'package:aquabook/app.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/models/app_notification_model.dart';
import 'package:aquabook/src/features/shared/chat/domain/models/chat_conversation_arguments.dart';
import 'package:aquabook/src/features/shared/notifications/cubit/notifications_cubit.dart';
import 'package:aquabook/src/features/shared/notifications/cubit/notifications_state.dart';
import 'package:aquabook/src/features/shared/notifications/presentation/widgets/notification_tile.dart';
import 'package:aquabook/src/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<NotificationsCubit>()..load(),
    child: Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(title: 'Notifications'),
            Expanded(
              child: BlocBuilder<NotificationsCubit, NotificationsState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.errorMessage != null) {
                    return Center(child: Text(state.errorMessage!));
                  }
                  if (state.notifications.isEmpty) {
                    return const Center(
                      child: Text(
                        'You have no notifications yet.',
                        style: TextStyle(color: AppColors.muted),
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                    itemCount: state.notifications.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final notification = state.notifications[index];
                      return NotificationTile(
                        notification: notification,
                        onTap: () => _openNotification(context, notification),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Future<void> _openNotification(
    BuildContext context,
    AppNotificationModel notification,
  ) async {
    await context.read<NotificationsCubit>().markAsRead(notification.id);
    final data = notification.data;
    if (data['type'] != 'chat_message') return;
    final required = [
      data['businessId'],
      data['businessOwnerId'],
      data['businessName'],
      data['customerId'],
      data['customerName'],
    ];
    if (required.any((value) => value == null || value.isEmpty)) return;
    if (!context.mounted) return;
    context.push(
      AppRoutes.CHAT_CONVERSATION,
      extra: ChatConversationArguments(
        businessId: data['businessId']!,
        businessOwnerId: data['businessOwnerId']!,
        businessName: data['businessName']!,
        businessImageUrl: data['businessImageUrl'] ?? '',
        customerId: data['customerId']!,
        customerName: data['customerName']!,
        customerImageUrl: data['customerImageUrl'],
      ),
    );
  }
}
