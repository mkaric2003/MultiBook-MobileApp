import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/enums/stay_amenity.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class StayAmenitiesSelector extends StatelessWidget {
  const StayAmenitiesSelector({
    super.key,
    required this.selectedAmenities,
    required this.onChanged,
  });

  final List<StayAmenity> selectedAmenities;
  final ValueChanged<StayAmenity> onChanged;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: StayAmenity.values
        .map(
          (amenity) => FilterChip(
            label: Text(context.l10n.stayAmenity(amenity)),
            selected: selectedAmenities.contains(amenity),
            onSelected: (_) => onChanged(amenity),
            selectedColor: AppColors.primary,
            checkmarkColor: AppColors.white,
            side: BorderSide(color: context.appPalette.border),
          ),
        )
        .toList(),
  );
}
