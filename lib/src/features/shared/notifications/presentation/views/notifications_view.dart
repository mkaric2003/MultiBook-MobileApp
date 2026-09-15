import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/models/app_notification_model.dart';
import 'package:multibook/src/features/shared/notifications/cubit/notifications_cubit.dart';
import 'package:multibook/src/features/shared/notifications/cubit/notifications_state.dart';
import 'package:multibook/src/features/shared/notifications/presentation/navigation/notification_router.dart';
import 'package:multibook/src/features/shared/notifications/presentation/widgets/notification_tile.dart';
import 'package:multibook/src/features/shared/notifications/presentation/widgets/notifications_skeleton.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<NotificationsCubit>()..load(),
    child: Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: context.l10n.notifications),
            Expanded(
              child: BlocBuilder<NotificationsCubit, NotificationsState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const NotificationsSkeleton();
                  }
                  if (state.errorMessage != null) {
                    return Center(child: Text(state.errorMessage!));
                  }
                  if (state.notifications.isEmpty) {
                    return Center(
                      child: Text(
                        context.l10n.noNotificationsYet,
                        style: TextStyle(color: context.appPalette.muted),
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
    if (!context.mounted) return;
    NotificationRouter(GoRouter.of(context)).open(data);
  }
}
