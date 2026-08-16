import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:flutter/material.dart';

class DashboardBusinessHeader extends StatelessWidget {
  const DashboardBusinessHeader({
    super.key,
    required this.business,
    required this.onSwitchBusiness,
  });

  final BusinessModel business;
  final VoidCallback onSwitchBusiness;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 45,
          width: 50,
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
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                business.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              InkWell(
                onTap: onSwitchBusiness,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Switch business',
                      style: TextStyle(color: AppColors.muted, fontSize: 16),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_down, color: AppColors.muted),
                  ],
                ),
              ),
            ],
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(Icons.notifications, size: 29),
            Positioned(
              top: -2,
              right: -2,
              child: Container(
                height: 15,
                width: 15,
                decoration: const BoxDecoration(
                  color: Color(0xFFF05252),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
