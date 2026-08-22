import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/global_widgets/searchable_city_picker_sheet.dart';
import 'package:flutter/material.dart';

class ExploreAppBar extends StatelessWidget {
  const ExploreAppBar({
    required this.selectedCity,
    required this.cities,
    required this.onCityChanged,
    this.trailing,
    super.key,
  });

  final String? selectedCity;
  final List<String> cities;
  final ValueChanged<String?> onCityChanged;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => Container(
    height: 86,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    alignment: Alignment.centerLeft,
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: AppColors.surfaceHighlight)),
    ),
    child: Row(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(10),
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
              onCityChanged(city);
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.location_on_rounded,
                color: AppColors.primary,
                size: 18,
              ),
              const SizedBox(width: 4),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 94),
                child: Text(
                  selectedCity?.isNotEmpty == true
                      ? selectedCity!
                      : context.l10n.allCities,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.muted,
                size: 18,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Text(
          context.l10n.explore,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        const Spacer(),
        if (trailing != null) trailing!,
      ],
    ),
  );
}
