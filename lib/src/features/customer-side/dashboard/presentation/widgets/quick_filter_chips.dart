import 'package:aquabook/src/data/enums/stay_amenity.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_filters.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/quick_filter_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class QuickFilterChips extends HookWidget {
  const QuickFilterChips({
    required this.filters,
    required this.onChanged,
    super.key,
  });

  final StayFilters filters;
  final ValueChanged<StayFilters> onChanged;

  static const _quickAmenities = [
    StayAmenity.petFriendly,
    StayAmenity.parking,
    StayAmenity.pool,
    StayAmenity.spa,
  ];

  @override
  Widget build(BuildContext context) {
    final now = DateUtils.dateOnly(DateTime.now());
    final tomorrow = now.add(const Duration(days: 1));
    final weekendStart = now.add(
      Duration(days: (DateTime.saturday - now.weekday + 7) % 7),
    );
    final weekendEnd = weekendStart.add(const Duration(days: 2));

    final isTodaySelected =
        filters.checkIn == now && filters.checkOut == tomorrow;
    final isWeekendSelected =
        filters.checkIn == weekendStart && filters.checkOut == weekendEnd;

    void toggleDates({
      required bool isSelected,
      required DateTime checkIn,
      required DateTime checkOut,
    }) {
      onChanged(
        isSelected
            ? filters.copyWith(clearCheckIn: true, clearCheckOut: true)
            : filters.copyWith(checkIn: checkIn, checkOut: checkOut),
      );
    }

    void toggleAmenity(StayAmenity amenity) {
      final amenities = [...filters.amenities];
      if (amenities.contains(amenity)) {
        amenities.remove(amenity);
      } else {
        amenities.add(amenity);
      }
      onChanged(filters.copyWith(amenities: amenities));
    }

    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 2 + _quickAmenities.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          if (index == 0 || index == 1) {
            final isToday = index == 0;
            final isSelected = isToday ? isTodaySelected : isWeekendSelected;
            return QuickFilterChip(
              label: isToday ? context.l10n.today : context.l10n.weekend,
              isSelected: isSelected,
              onTap: () => toggleDates(
                isSelected: isSelected,
                checkIn: isToday ? now : weekendStart,
                checkOut: isToday ? tomorrow : weekendEnd,
              ),
            );
          }

          final amenity = _quickAmenities[index - 2];
          return QuickFilterChip(
            label: amenity.label,
            isSelected: filters.amenities.contains(amenity),
            onTap: () => toggleAmenity(amenity),
          );
        },
      ),
    );
  }
}
