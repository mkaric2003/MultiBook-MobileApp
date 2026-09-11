import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class BusinessTypeSelector extends StatelessWidget {
  const BusinessTypeSelector({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  final BusinessType selectedType;
  final ValueChanged<BusinessType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.appPalette.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _BusinessTypeOption(
            label: context.l10n.stays,
            isSelected: selectedType == BusinessType.stays,
            onTap: () => onChanged(BusinessType.stays),
          ),
          _BusinessTypeOption(
            label: context.l10n.services,
            isSelected: selectedType == BusinessType.services,
            onTap: () => onChanged(BusinessType.services),
          ),
        ],
      ),
    );
  }
}

class _BusinessTypeOption extends StatelessWidget {
  const _BusinessTypeOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(9),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.white : context.appPalette.muted,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
