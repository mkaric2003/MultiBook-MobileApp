import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/stay_extra_type.dart';
import 'package:flutter/material.dart';

class StayExtrasSelector extends StatelessWidget {
  const StayExtrasSelector({
    super.key,
    required this.selectedExtras,
    required this.onChanged,
  });
  final List<StayExtraType> selectedExtras;
  final ValueChanged<StayExtraType> onChanged;
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 10,
    runSpacing: 10,
    children: [
      for (final extra in StayExtraType.values)
        FilterChip(
          label: Text(extra.label),
          selected: selectedExtras.contains(extra),
          onSelected: (_) => onChanged(extra),
          selectedColor: AppColors.primary,
          checkmarkColor: Colors.white,
          side: const BorderSide(color: AppColors.border),
        ),
    ],
  );
}
