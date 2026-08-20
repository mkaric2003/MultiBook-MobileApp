import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/features/shared/notifications/presentation/widgets/notification_bell.dart';
import 'package:flutter/material.dart';

class DashboardBusinessHeader extends StatelessWidget {
  const DashboardBusinessHeader({
    super.key,
    required this.business,
    required this.onSwitchBusiness,
    required this.onNotificationsPressed,
  });

  final BusinessModel business;
  final VoidCallback onSwitchBusiness;
  final VoidCallback onNotificationsPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 44,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.border,
            borderRadius: BorderRadius.circular(10),
          ),
          child: business.logoUrl == null
              ? const Icon(Icons.storefront, color: AppColors.white)
              : Image.network(
                  business.logoUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                      const Icon(Icons.storefront, color: AppColors.white),
                ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                business.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              InkWell(
                onTap: onSwitchBusiness,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Switch business',
                      style: TextStyle(color: AppColors.muted, fontSize: 13),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.muted,
                      size: 19,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        NotificationBell(size: 25, onTap: onNotificationsPressed),
      ],
    );
  }
}
