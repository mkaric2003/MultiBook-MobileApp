import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_filters.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_category_filter_options.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/service_filters/service_city_selector.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/service_filters/service_filter_date_picker_sheet.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/service_filters/service_filter_option_picker_sheet.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/service_filters/service_filter_price_range.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/service_filters/service_filter_section_header.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/service_filters/service_filter_time_picker_sheet.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/service_filters/service_filter_value_field.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/service_filters/service_sort_selector.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ServiceFiltersSheet extends HookWidget {
  const ServiceFiltersSheet({super.key, required this.initialFilters});

  static const _cities = [
    'Sarajevo',
    'Mostar',
    'Banja Luka',
    'Tuzla',
    'Zenica',
    'Bihać',
    'Trebinje',
    'Neum',
    'Ilidža',
    'Jajce',
    'Travnik',
    'Konjic',
    'Visoko',
    'Prijedor',
    'Brčko',
    'Bijeljina',
    'Doboj',
    'San Francisco',
  ];

  final ServiceFilters initialFilters;

  @override
  Widget build(BuildContext context) {
    final filters = useState(initialFilters);

    Future<void> selectDate() async {
      final selected = await showModalBottomSheet<DateTime>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => ServiceFilterDatePickerSheet(
          initialDate: filters.value.date ?? DateTime.now(),
        ),
      );
      if (selected != null) {
        filters.value = filters.value.copyWith(date: selected);
      }
    }

    Future<void> selectTime() async {
      final selected = await showModalBottomSheet<int>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => ServiceFilterTimePickerSheet(
          initialMinutes: filters.value.timeMinutes ?? 540,
        ),
      );
      if (selected != null) {
        filters.value = filters.value.copyWith(timeMinutes: selected);
      }
    }

    Future<void> selectCategory() async {
      final selected = await showModalBottomSheet<String>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (_) => ServiceFilterOptionPickerSheet(
          title: 'Select category',
          allOptionLabel: 'All categories',
          options: ServiceCategoryFilterOptions.all
              .map((category) => category.label)
              .toList(),
          selectedOption: ServiceCategoryFilterOptions.byId(
            filters.value.categoryId,
          )?.label,
        ),
      );
      if (selected != null) {
        filters.value = selected.isEmpty
            ? filters.value.copyWith(clearCategoryId: true)
            : filters.value.copyWith(
                categoryId: ServiceCategoryFilterOptions.byLabel(selected)?.id,
              );
      }
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
                      onPressed: () => filters.value = const ServiceFilters(),
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
                    const ServiceFilterSectionHeader(
                      icon: Icons.calendar_month_rounded,
                      title: 'Date & time',
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ServiceFilterValueField(
                            label: 'Date',
                            value: filters.value.date == null
                                ? 'Any date'
                                : MaterialLocalizations.of(
                                    context,
                                  ).formatMediumDate(filters.value.date!),
                            onTap: selectDate,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ServiceFilterValueField(
                            label: 'Time',
                            value: filters.value.timeMinutes == null
                                ? 'Any time'
                                : _formatTime(
                                    context,
                                    filters.value.timeMinutes!,
                                  ),
                            onTap: selectTime,
                          ),
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
                    const ServiceFilterSectionHeader(
                      icon: Icons.content_cut_rounded,
                      title: 'Business category',
                    ),
                    const SizedBox(height: 16),
                    ServiceFilterValueField(
                      label: 'Category',
                      value:
                          ServiceCategoryFilterOptions.byId(
                            filters.value.categoryId,
                          )?.label ??
                          'All categories',
                      onTap: selectCategory,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Divider(
                        height: 1,
                        color: AppColors.surfaceHighlight,
                      ),
                    ),
                    const ServiceFilterSectionHeader(
                      icon: Icons.location_city_rounded,
                      title: 'City',
                    ),
                    const SizedBox(height: 16),
                    ServiceCitySelector(
                      cities: _cities,
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
                    const ServiceFilterSectionHeader(
                      icon: Icons.attach_money_rounded,
                      title: 'Price range',
                    ),
                    const SizedBox(height: 8),
                    ServiceFilterPriceRange(
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
                    const ServiceFilterSectionHeader(
                      icon: Icons.sort_rounded,
                      title: 'Sort by',
                    ),
                    const SizedBox(height: 8),
                    ServiceSortSelector(
                      selected: filters.value.sortOption,
                      onChanged: (sortOption) => filters.value = filters.value
                          .copyWith(sortOption: sortOption),
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
                        onPressed: () => filters.value = const ServiceFilters(),
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

  String _formatTime(BuildContext context, int minutes) {
    return TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60).format(context);
  }
}
