import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchableCityPickerSheet extends HookWidget {
  const SearchableCityPickerSheet({
    super.key,
    required this.cities,
    required this.selectedCity,
  });

  final List<String> cities;
  final String? selectedCity;

  @override
  Widget build(BuildContext context) {
    final query = useState('');
    final controller = useTextEditingController();
    final normalizedQuery = query.value.trim().toLowerCase();
    final filteredCities = cities
        .where((city) => city.toLowerCase().contains(normalizedQuery))
        .toList();
    final canUseTypedCity =
        normalizedQuery.isNotEmpty &&
        !cities.any((city) => city.toLowerCase() == normalizedQuery);

    return Material(
      color: AppColors.background,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 480,
          child: Column(
            children: [
              Container(
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.surfaceHighlight),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        context.l10n.selectCity,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: TextField(
                  controller: controller,
                  autofocus: true,
                  onChanged: (value) => query.value = value,
                  style: const TextStyle(color: AppColors.white),
                  decoration: InputDecoration(
                    hintText: context.l10n.searchCities,
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.muted,
                    ),
                    suffixIcon: query.value.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () {
                              controller.clear();
                              query.value = '';
                            },
                            icon: const Icon(Icons.close_rounded),
                          ),
                    filled: true,
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(context.l10n.allCities),
                      trailing: selectedCity == null
                          ? const Icon(
                              Icons.check_rounded,
                              color: AppColors.primary,
                            )
                          : null,
                      onTap: () => Navigator.of(context).pop(''),
                    ),
                    if (filteredCities.isEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 32),
                        child: Center(
                          child: Text(
                            context.l10n.noCitiesFound,
                            style: TextStyle(color: AppColors.muted),
                          ),
                        ),
                      ),
                    if (canUseTypedCity)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(
                          Icons.add_location_alt_outlined,
                          color: AppColors.primary,
                        ),
                        title: Text(context.l10n.useCity(query.value.trim())),
                        onTap: () =>
                            Navigator.of(context).pop(query.value.trim()),
                      ),
                    for (final city in filteredCities)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(city),
                        trailing: city == selectedCity
                            ? const Icon(
                                Icons.check_rounded,
                                color: AppColors.primary,
                              )
                            : null,
                        onTap: () => Navigator.of(context).pop(city),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
