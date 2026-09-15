import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/enums/stay_amenity.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class AmenitiesSelector extends StatelessWidget {
  const AmenitiesSelector({
    super.key,
    required this.selectedAmenities,
    required this.onChanged,
  });

  final List<StayAmenity> selectedAmenities;
  final ValueChanged<StayAmenity> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final amenity in StayAmenity.values)
          FilterChip(
            label: Text(context.l10n.stayAmenity(amenity)),
            selected: selectedAmenities.contains(amenity),
            onSelected: (_) => onChanged(amenity),
            selectedColor: AppColors.primary,
            checkmarkColor: Colors.white,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            side: BorderSide(color: context.appPalette.border),
          ),
      ],
    );
  }
}
