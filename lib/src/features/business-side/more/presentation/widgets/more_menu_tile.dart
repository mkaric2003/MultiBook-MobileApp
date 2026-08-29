import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/business-side/more/domain/models/more_menu_item.dart';
import 'package:flutter/material.dart';

class MoreMenuTile extends StatelessWidget {
  const MoreMenuTile({super.key, required this.item});

  final MoreMenuItem item;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: item.onTap,
    child: SizedBox(
      height: 72,
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF3F3375),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(item.icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item.label,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
          if (item.badgeCount != null) ...[
            Container(
              height: 26,
              width: 26,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xFFFF4B4B),
                shape: BoxShape.circle,
              ),
              child: Text(
                '${item.badgeCount}',
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(width: 8),
          ],
          const Icon(Icons.chevron_right, color: AppColors.muted, size: 24),
        ],
      ),
    ),
  );
}
