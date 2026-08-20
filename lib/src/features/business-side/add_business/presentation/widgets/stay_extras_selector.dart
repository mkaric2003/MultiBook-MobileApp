import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/stay_extra_type.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/stay_extra_price_field.dart';
import 'package:flutter/material.dart';

class StayExtrasSelector extends StatelessWidget {
  const StayExtrasSelector({
    super.key,
    required this.selectedExtras,
    required this.extraPrices,
    required this.onChanged,
    required this.onPriceChanged,
  });
  final List<StayExtraType> selectedExtras;
  final Map<String, int> extraPrices;
  final ValueChanged<StayExtraType> onChanged;
  final void Function(StayExtraType extra, int price) onPriceChanged;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          for (final extra in StayExtraType.values)
            FilterChip(
              label: Text(extra.label),
              selected: selectedExtras.contains(extra),
              onSelected: (_) => onChanged(extra),
              selectedColor: AppColors.primary,
              checkmarkColor: Colors.white,
              side: const BorderSide(color: AppColors.border),
            ),
        ],
      ),
      if (selectedExtras.isNotEmpty) ...[
        const SizedBox(height: 14),
        ...selectedExtras.map(
          (extra) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: StayExtraPriceField(
              extra: extra,
              price: extraPrices[extra.name] ?? extra.defaultPrice,
              onPriceChanged: (price) => onPriceChanged(extra, price),
            ),
          ),
        ),
      ],
    ],
  );
}
