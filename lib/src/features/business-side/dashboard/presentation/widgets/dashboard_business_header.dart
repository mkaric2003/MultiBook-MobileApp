import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/features/shared/notifications/presentation/widgets/notification_bell.dart';
import 'package:multibook/l10n/l10n.dart';
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
            color: context.appPalette.border,
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.l10n.switchBusiness,
                      style: TextStyle(
                        color: context.appPalette.muted,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: context.appPalette.muted,
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
