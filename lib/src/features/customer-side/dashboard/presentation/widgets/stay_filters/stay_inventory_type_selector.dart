import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/data/enums/stay_inventory_type.dart';
import 'package:flutter/material.dart';

class StayInventoryTypeSelector extends StatelessWidget {
  const StayInventoryTypeSelector({
    super.key,
    required this.selectedInventoryType,
    required this.onChanged,
  });

  final StayInventoryType? selectedInventoryType;
  final ValueChanged<StayInventoryType> onChanged;

  @override
  Widget build(BuildContext context) {
    final isSingleUnitSelected =
        selectedInventoryType == StayInventoryType.singleUnit;
    final isMultipleUnitsSelected =
        selectedInventoryType == StayInventoryType.multipleUnits;

    return Wrap(
      spacing: 8,
      children: [
        FilterChip(
          label: Text(context.l10n.entirePlace),
          labelStyle: TextStyle(
            color: isSingleUnitSelected ? AppColors.white : null,
          ),
          selected: isSingleUnitSelected,
          onSelected: (_) => onChanged(StayInventoryType.singleUnit),
          selectedColor: AppColors.primary,
          checkmarkColor: AppColors.white,
          side: BorderSide(color: context.appPalette.border),
        ),
        FilterChip(
          label: Text(context.l10n.roomOrUnit),
          labelStyle: TextStyle(
            color: isMultipleUnitsSelected ? AppColors.white : null,
          ),
          selected: isMultipleUnitsSelected,
          onSelected: (_) => onChanged(StayInventoryType.multipleUnits),
          selectedColor: AppColors.primary,
          checkmarkColor: AppColors.white,
          side: BorderSide(color: context.appPalette.border),
        ),
      ],
    );
  }
}
