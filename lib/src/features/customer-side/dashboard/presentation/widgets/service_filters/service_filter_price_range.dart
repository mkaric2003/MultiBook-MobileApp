import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ServiceFilterPriceRange extends StatelessWidget {
  const ServiceFilterPriceRange({
    super.key,
    required this.values,
    required this.onChanged,
  });

  final RangeValues values;
  final ValueChanged<RangeValues> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RangeSlider(
          values: values,
          min: 0,
          max: 500,
          divisions: 50,
          activeColor: AppColors.primary,
          inactiveColor: AppColors.surface,
          labels: RangeLabels(
            '\$${values.start.round()}',
            '\$${values.end.round()}',
          ),
          onChanged: onChanged,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${values.start.round()}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '\$${values.end.round()}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
