import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/business-side/more/domain/models/more_menu_item.dart';
import 'package:multibook/src/features/business-side/more/presentation/widgets/more_menu_tile.dart';
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
        style: TextStyle(
          color: context.appPalette.muted,
          fontSize: 13,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: context.appPalette.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            for (var index = 0; index < items.length; index++) ...[
              MoreMenuTile(item: items[index]),
              if (index < items.length - 1)
                Divider(height: 1, color: context.appPalette.surfaceHighlight),
            ],
          ],
        ),
      ),
    ],
  );
}
