import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/enums/stay_inventory_type.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/features/business-side/add_business/presentation/widgets/stay_inventory_type_option.dart';
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
      color: context.appPalette.surface,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        Expanded(
          child: StayInventoryTypeOption(
            title: context.l10n.singleUnit,
            subtitle: context.l10n.oneBookableStay,
            isSelected: selectedType == StayInventoryType.singleUnit,
            onTap: () => onChanged(StayInventoryType.singleUnit),
          ),
        ),
        Expanded(
          child: StayInventoryTypeOption(
            title: context.l10n.multipleUnits,
            subtitle: context.l10n.roomsOrUnits,
            isSelected: selectedType == StayInventoryType.multipleUnits,
            onTap: () => onChanged(StayInventoryType.multipleUnits),
          ),
        ),
      ],
    ),
  );
}
