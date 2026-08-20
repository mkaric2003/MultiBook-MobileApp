import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/stay_extra_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StayExtraPriceField extends StatelessWidget {
  const StayExtraPriceField({
    super.key,
    required this.extra,
    required this.price,
    required this.onPriceChanged,
  });

  final StayExtraType extra;
  final int price;
  final ValueChanged<int> onPriceChanged;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
    decoration: BoxDecoration(
      color: AppColors.surface,
      border: Border.all(color: AppColors.border),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                extra.label,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 3),
              Text(
                extra.isPerHour
                    ? 'Charged per hour'
                    : extra.isPerNight
                    ? 'Charged per night'
                    : 'One-time charge',
                style: const TextStyle(color: AppColors.muted, fontSize: 12),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 92,
          child: TextFormField(
            key: ValueKey(extra),
            initialValue: price.toString(),
            onChanged: (value) => onPriceChanged(int.tryParse(value) ?? 0),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              prefixText: '\$',
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
