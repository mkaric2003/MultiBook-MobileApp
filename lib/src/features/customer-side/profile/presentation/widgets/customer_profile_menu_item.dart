import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomerProfileMenuItem extends StatelessWidget {
  const CustomerProfileMenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.badgeCount,
    this.onTap,
  });
  final IconData icon;
  final String label;
  final int? badgeCount;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(14),
    child: Container(
      height: 78,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: context.appPalette.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: context.appPalette.surfaceHighlight,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
          ),
          if (badgeCount != null) ...[
            Container(
              height: 26,
              width: 26,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xFFFF4B4B),
                shape: BoxShape.circle,
              ),
              child: Text(
                '${badgeCount! > 9 ? '9+' : badgeCount}',
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Icon(Icons.chevron_right, color: context.appPalette.muted),
        ],
      ),
    ),
  );
}
