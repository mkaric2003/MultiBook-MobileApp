import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/stay_inventory_type.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/stay_inventory_type_option.dart';
import 'package:flutter/material.dart';

class StayInventoryTypeSelector extends StatelessWidget {
  const StayInventoryTypeSelector({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  final StayInventoryType selectedType;
  final ValueChanged<StayInventoryType> onChanged;

  @override
  Widget build(BuildContext context) => Container(
    height: 84,
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        Expanded(
          child: StayInventoryTypeOption(
            title: 'Single unit',
            subtitle: 'One bookable stay',
            isSelected: selectedType == StayInventoryType.singleUnit,
            onTap: () => onChanged(StayInventoryType.singleUnit),
          ),
        ),
        Expanded(
          child: StayInventoryTypeOption(
            title: 'Multiple units',
            subtitle: 'Rooms or units',
            isSelected: selectedType == StayInventoryType.multipleUnits,
            onTap: () => onChanged(StayInventoryType.multipleUnits),
          ),
        ),
      ],
    ),
  );
}
