import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_category_filter_option.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class StayCategorySelector extends StatelessWidget {
  const StayCategorySelector({
    super.key,
    required this.selectedCategoryIds,
    required this.onChanged,
  });

  static const _categories = [
    StayCategoryFilterOption(id: 'hotel', label: 'Hotels'),
    StayCategoryFilterOption(id: 'apartment', label: 'Apartments'),
    StayCategoryFilterOption(id: 'villa', label: 'Villas'),
    StayCategoryFilterOption(id: 'beach_villa', label: 'Beach villas'),
    StayCategoryFilterOption(id: 'pool_villa', label: 'Pool villas'),
    StayCategoryFilterOption(id: 'cabin', label: 'Cabins'),
    StayCategoryFilterOption(id: 'mountain_cabin', label: 'Mountain cabins'),
    StayCategoryFilterOption(id: 'cottage', label: 'Weekend homes'),
    StayCategoryFilterOption(id: 'resort', label: 'Resorts'),
    StayCategoryFilterOption(id: 'guesthouse', label: 'Guesthouses'),
    StayCategoryFilterOption(id: 'hostel', label: 'Hostels'),
    StayCategoryFilterOption(id: 'aparthotel', label: 'Aparthotels'),
    StayCategoryFilterOption(id: 'glamping', label: 'Glamping'),
    StayCategoryFilterOption(id: 'vacation_home', label: 'Vacation homes'),
  ];

  final List<String> selectedCategoryIds;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: _categories
        .map(
          (category) => FilterChip(
            label: Text(context.l10n.businessCategoryName(category.id)),
            selected: selectedCategoryIds.contains(category.id),
            onSelected: (_) => onChanged(category.id),
            selectedColor: AppColors.primary,
            checkmarkColor: AppColors.white,
            side: const BorderSide(color: AppColors.border),
          ),
        )
        .toList(),
  );
}
