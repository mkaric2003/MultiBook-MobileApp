import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_filters.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/stay_filters/filter_section_header.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/stay_filters/stay_city_selector.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/stay_filters/stay_filter_date_field.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/stay_filters/stay_filter_date_picker_sheet.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/stay_filters/stay_guest_stepper.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/stay_filters/stay_price_range.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/stay_filters/stay_rating_selector.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StayFiltersSheet extends HookWidget {
  const StayFiltersSheet({
    super.key,
    required this.initialFilters,
    required this.cities,
  });

  final StayFilters initialFilters;
  final List<String> cities;

  @override
  Widget build(BuildContext context) {
    final filters = useState(initialFilters);

    Future<void> selectDate({required bool isCheckIn}) async {
      final current = filters.value;
      final minimumDate = isCheckIn
          ? DateTime.now()
          : current.checkIn ?? DateTime.now();
      final selected = await showModalBottomSheet<DateTime>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => StayFilterDatePickerSheet(
          title: isCheckIn ? 'Check-in date' : 'Check-out date',
          initialDate: isCheckIn
              ? current.checkIn ?? minimumDate
              : current.checkOut ?? minimumDate,
          minimumDate: minimumDate,
        ),
      );
      if (selected == null) return;
      filters.value = isCheckIn
          ? current.copyWith(
              checkIn: selected,
              clearCheckOut:
                  current.checkOut != null &&
                  current.checkOut!.isBefore(selected),
            )
          : current.copyWith(checkOut: selected);
    }

    return Material(
      color: AppColors.background,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.surfaceHighlight),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () => filters.value = const StayFilters(),
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Filters',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close_rounded),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.surface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FilterSectionHeader(
                      icon: Icons.calendar_month_rounded,
                      title: 'Dates',
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        StayFilterDateField(
                          label: 'Check-in',
                          date: filters.value.checkIn,
                          onTap: () => selectDate(isCheckIn: true),
                        ),
                        const SizedBox(width: 12),
                        StayFilterDateField(
                          label: 'Check-out',
                          date: filters.value.checkOut,
                          onTap: () => selectDate(isCheckIn: false),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Divider(
                        height: 1,
                        color: AppColors.surfaceHighlight,
                      ),
                    ),
                    const FilterSectionHeader(
                      icon: Icons.people_alt_rounded,
                      title: 'Guests',
                    ),
                    const SizedBox(height: 16),
                    StayGuestStepper(
                      title: 'Adults',
                      subtitle: 'Ages 13 or above',
                      value: filters.value.adults,
                      minimum: 1,
                      onChanged: (value) =>
                          filters.value = filters.value.copyWith(adults: value),
                    ),
                    const SizedBox(height: 16),
                    StayGuestStepper(
                      title: 'Children',
                      subtitle: 'Ages 2–12',
                      value: filters.value.children,
                      minimum: 0,
                      onChanged: (value) => filters.value = filters.value
                          .copyWith(children: value),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Divider(
                        height: 1,
                        color: AppColors.surfaceHighlight,
                      ),
                    ),
                    const FilterSectionHeader(
                      icon: Icons.location_city_rounded,
                      title: 'City',
                    ),
                    const SizedBox(height: 16),
                    StayCitySelector(
                      cities: cities,
                      selectedCity: filters.value.city,
                      onChanged: (city) => filters.value = filters.value
                          .copyWith(city: city, clearCity: city == null),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Divider(
                        height: 1,
                        color: AppColors.surfaceHighlight,
                      ),
                    ),
                    const FilterSectionHeader(
                      icon: Icons.attach_money_rounded,
                      title: 'Price range',
                    ),
                    const SizedBox(height: 8),
                    StayPriceRange(
                      values: RangeValues(
                        filters.value.minPrice,
                        filters.value.maxPrice,
                      ),
                      onChanged: (values) =>
                          filters.value = filters.value.copyWith(
                            minPrice: values.start,
                            maxPrice: values.end,
                          ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Divider(
                        height: 1,
                        color: AppColors.surfaceHighlight,
                      ),
                    ),
                    const FilterSectionHeader(
                      icon: Icons.star_rounded,
                      title: 'Rating',
                    ),
                    const SizedBox(height: 12),
                    StayRatingSelector(
                      minimumRating: filters.value.minimumRating,
                      onChanged: (value) => filters.value = filters.value
                          .copyWith(minimumRating: value),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 20),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.surfaceHighlight),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${filters.value.appliedFiltersCount} filters applied',
                        style: const TextStyle(color: AppColors.muted),
                      ),
                      TextButton(
                        onPressed: () => filters.value = const StayFilters(),
                        child: const Text('Clear all'),
                      ),
                    ],
                  ),
                  CustomButton(
                    buttonName: 'Show results',
                    onPressed: () => Navigator.of(context).pop(filters.value),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
