import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/enums/stay_collection.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class StayCollectionsSelector extends StatelessWidget {
  const StayCollectionsSelector({
    required this.selectedCollectionIds,
    required this.onChanged,
    super.key,
  });

  final List<String> selectedCollectionIds;
  final ValueChanged<StayCollection> onChanged;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: StayCollection.values
        .map(
          (collection) => FilterChip(
            label: Text(context.l10n.stayCollectionName(collection)),
            selected: selectedCollectionIds.contains(collection.id),
            onSelected: (_) => onChanged(collection),
            selectedColor: AppColors.primary,
            backgroundColor: context.appPalette.surface,
            side: BorderSide(color: context.appPalette.surfaceHighlight),
            labelStyle: TextStyle(
              color: selectedCollectionIds.contains(collection.id)
                  ? AppColors.white
                  : context.appPalette.muted,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
        .toList(),
  );
}
