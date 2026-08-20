import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/enums/service_sort_option.dart';
import 'package:flutter/material.dart';

class ServiceSortSelector extends StatelessWidget {
  const ServiceSortSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final ServiceSortOption selected;
  final ValueChanged<ServiceSortOption> onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<ServiceSortOption>(
      groupValue: selected,
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
      child: Column(
        children: [
          for (final option in ServiceSortOption.values)
            RadioListTile<ServiceSortOption>(
              value: option,
              activeColor: AppColors.primary,
              contentPadding: EdgeInsets.zero,
              title: Text(option.label, style: const TextStyle(fontSize: 16)),
            ),
        ],
      ),
    );
  }
}
