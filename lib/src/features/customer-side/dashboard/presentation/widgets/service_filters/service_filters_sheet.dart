import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_filters.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_category_filter_options.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/service_filters/service_city_selector.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/service_filters/service_filter_date_picker_sheet.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/service_filters/service_filter_option_picker_sheet.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/service_filters/service_filter_price_range.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/service_filters/service_filter_section_header.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/service_filters/service_filter_time_picker_sheet.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/service_filters/service_filter_value_field.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/service_filters/service_sort_selector.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
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

    String? categoryNameForId(String? id) {
      final category = ServiceCategoryFilterOptions.byId(id);
      return category == null
          ? null
          : context.l10n.businessCategoryName(category.id);
    }

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
          title: context.l10n.category,
          allOptionLabel: context.l10n.allCategories,
          options: ServiceCategoryFilterOptions.all
              .map((category) => context.l10n.businessCategoryName(category.id))
              .toList(),
          selectedOption: categoryNameForId(filters.value.categoryId),
        ),
      );
      if (selected != null) {
        filters.value = selected.isEmpty
            ? filters.value.copyWith(clearCategoryId: true)
            : filters.value.copyWith(
                categoryId: ServiceCategoryFilterOptions.all
                    .where(
                      (category) =>
                          context.l10n.businessCategoryName(category.id) ==
                          selected,
                    )
                    .firstOrNull
                    ?.id,
              );
      }
    }

    return Material(
      color: context.appPalette.background,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: context.appPalette.surfaceHighlight,
                  ),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () => filters.value = const ServiceFilters(),
                      child: Text(
                        context.l10n.reset,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    context.l10n.filters,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close_rounded),
                      style: IconButton.styleFrom(
                        backgroundColor: context.appPalette.surface,
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
                    ServiceFilterSectionHeader(
                      icon: Icons.calendar_month_rounded,
                      title: context.l10n.dateAndTime,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ServiceFilterValueField(
                            label: context.l10n.date,
                            value: filters.value.date == null
                                ? context.l10n.anyDate
                                : MaterialLocalizations.of(
                                    context,
                                  ).formatMediumDate(filters.value.date!),
                            onTap: selectDate,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ServiceFilterValueField(
                            label: context.l10n.time,
                            value: filters.value.timeMinutes == null
                                ? context.l10n.anyTime
                                : _formatTime(
                                    context,
                                    filters.value.timeMinutes!,
                                  ),
                            onTap: selectTime,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Divider(
                        height: 1,
                        color: context.appPalette.surfaceHighlight,
                      ),
                    ),
                    ServiceFilterSectionHeader(
                      icon: Icons.content_cut_rounded,
                      title: context.l10n.businessCategory,
                    ),
                    const SizedBox(height: 16),
                    ServiceFilterValueField(
                      label: context.l10n.category,
                      value:
                          categoryNameForId(filters.value.categoryId) ??
                          context.l10n.allCategories,
                      onTap: selectCategory,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Divider(
                        height: 1,
                        color: context.appPalette.surfaceHighlight,
                      ),
                    ),
                    ServiceFilterSectionHeader(
                      icon: Icons.location_city_rounded,
                      title: context.l10n.city,
                    ),
                    const SizedBox(height: 16),
                    ServiceCitySelector(
                      cities: _cities,
                      selectedCity: filters.value.city,
                      onChanged: (city) => filters.value = filters.value
                          .copyWith(city: city, clearCity: city == null),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Divider(
                        height: 1,
                        color: context.appPalette.surfaceHighlight,
                      ),
                    ),
                    ServiceFilterSectionHeader(
                      icon: Icons.attach_money_rounded,
                      title: context.l10n.priceRange,
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
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Divider(
                        height: 1,
                        color: context.appPalette.surfaceHighlight,
                      ),
                    ),
                    ServiceFilterSectionHeader(
                      icon: Icons.sort_rounded,
                      title: context.l10n.sortBy,
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
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: context.appPalette.surfaceHighlight),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.filtersApplied(
                          filters.value.appliedFiltersCount,
                        ),
                        style: TextStyle(color: context.appPalette.muted),
                      ),
                      TextButton(
                        onPressed: () => filters.value = const ServiceFilters(),
                        child: Text(context.l10n.clearAll),
                      ),
                    ],
                  ),
                  CustomButton(
                    buttonName: context.l10n.showResults,
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
