import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/business-side/more/domain/models/more_menu_item.dart';
import 'package:aquabook/src/features/business-side/more/presentation/widgets/more_menu_tile.dart';
import 'package:flutter/material.dart';

class MoreMenuSection extends StatelessWidget {
  const MoreMenuSection({super.key, required this.title, required this.items});

  final String title;
  final List<MoreMenuItem> items;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: AppColors.muted,
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 17),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF172554),
          borderRadius: BorderRadius.circular(17),
        ),
        child: Column(
          children: [
            for (var index = 0; index < items.length; index++) ...[
              MoreMenuTile(item: items[index]),
              if (index < items.length - 1)
                const Divider(height: 1, color: AppColors.surfaceHighlight),
            ],
          ],
        ),
      ),
    ],
  );
}
