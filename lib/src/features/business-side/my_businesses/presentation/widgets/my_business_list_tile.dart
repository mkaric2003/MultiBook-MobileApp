import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/business_type.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:flutter/material.dart';

class MyBusinessListTile extends StatelessWidget {
  const MyBusinessListTile({
    super.key,
    required this.business,
    required this.onTap,
  });

  final BusinessModel business;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isStay = business.type == BusinessType.stays;
    final accentColor = isStay ? AppColors.primary : const Color(0xFF10B981);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.surfaceHighlight),
        ),
        child: Row(
          children: [
            Container(
              height: 58,
              width: 58,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: business.logoUrl == null
                  ? Icon(
                      isStay ? Icons.bed : Icons.content_cut,
                      color: AppColors.white,
                      size: 30,
                    )
                  : Image.network(business.logoUrl!, fit: BoxFit.cover),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    business.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Wrap(
                    spacing: 7,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: accentColor.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          isStay ? 'Stays' : 'Services',
                          style: TextStyle(
                            color: accentColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: AppColors.muted,
                              size: 17,
                            ),
                            const SizedBox(width: 3),
                            Expanded(
                              child: Text(
                                business.location.address,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.chevron_right,
              color: AppColors.iconMuted,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
