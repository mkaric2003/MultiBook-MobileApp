import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/global_widgets/searchable_city_picker_sheet.dart';
import 'package:flutter/material.dart';

class ServiceCitySelector extends StatelessWidget {
  const ServiceCitySelector({
    super.key,
    required this.cities,
    required this.selectedCity,
    required this.onChanged,
  });

  final List<String> cities;
  final String? selectedCity;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () async {
        final city = await showModalBottomSheet<String>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => SearchableCityPickerSheet(
            cities: cities,
            selectedCity: selectedCity,
          ),
        );
        if (context.mounted && city != null) {
          onChanged(city.isEmpty ? null : city);
        }
      },
      child: Container(
        height: 54,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: context.appPalette.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: context.appPalette.border),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedCity ?? 'All cities',
                style: TextStyle(
                  color: selectedCity == null
                      ? context.appPalette.muted
                      : context.appPalette.foreground,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: context.appPalette.muted,
            ),
          ],
        ),
      ),
    );
  }
}
