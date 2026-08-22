import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/data/enums/stay_inventory_type.dart';
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
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    children: [
      FilterChip(
        label: Text(context.l10n.entirePlace),
        selected: selectedInventoryType == StayInventoryType.singleUnit,
        onSelected: (_) => onChanged(StayInventoryType.singleUnit),
        selectedColor: AppColors.primary,
        checkmarkColor: AppColors.white,
        side: const BorderSide(color: AppColors.border),
      ),
      FilterChip(
        label: Text(context.l10n.roomOrUnit),
        selected: selectedInventoryType == StayInventoryType.multipleUnits,
        onSelected: (_) => onChanged(StayInventoryType.multipleUnits),
        selectedColor: AppColors.primary,
        checkmarkColor: AppColors.white,
        side: const BorderSide(color: AppColors.border),
      ),
    ],
  );
}
