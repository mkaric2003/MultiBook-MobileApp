import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/global_widgets/searchable_city_picker_sheet.dart';
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
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedCity ?? 'All cities',
                style: TextStyle(
                  color: selectedCity == null
                      ? AppColors.muted
                      : AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.muted,
            ),
          ],
        ),
      ),
    );
  }
}
