import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/data/models/app_notification_model.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  final AppNotificationModel notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final icon = switch (notification.kind) {
      'chat_message' => Icons.chat_bubble_rounded,
      'booking_created' || 'booking_status_changed' => Icons.bed_rounded,
      'appointment_created' ||
      'appointment_status_changed' => Icons.calendar_month_rounded,
      _ => Icons.notifications_rounded,
    };
    final now = DateTime.now();
    final difference = now.difference(notification.createdAt);
    final timeLabel = difference.inMinutes < 1
        ? context.l10n.now
        : difference.inHours < 1
        ? context.l10n.minutesAgo(difference.inMinutes)
        : difference.inDays < 1
        ? context.l10n.hoursAgo(difference.inHours)
        : context.l10n.daysAgo(difference.inDays);

    return Material(
      color: notification.isRead
          ? AppColors.surface
          : AppColors.surfaceHighlight,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: .16),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.primary, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: notification.isRead
                                  ? FontWeight.w600
                                  : FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.body,
                      maxLines: 2,
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
              Row(
                children: [
                  Text(
                    timeLabel,
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 12,
                    ),
                  ),
                  if (!notification.isRead) ...[
                    const SizedBox(width: 7),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
