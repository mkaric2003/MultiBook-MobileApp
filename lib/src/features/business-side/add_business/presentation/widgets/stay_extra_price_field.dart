import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/stay_extra_type.dart';
import 'package:aquabook/l10n/l10n.dart';
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
                context.l10n.stayExtra(extra),
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 3),
              Text(
                extra.isPerHour
                    ? context.l10n.chargedPerHour
                    : extra.isPerNight
                    ? context.l10n.chargedPerNight
                    : context.l10n.oneTimeCharge,
                style: const TextStyle(color: AppColors.muted, fontSize: 12),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 92,
          child: TextFormField(
            key: ValueKey(extra),
            initialValue: (price / 100).toStringAsFixed(
              price % 100 == 0 ? 0 : 2,
            ),
            onChanged: (value) =>
                onPriceChanged(((double.tryParse(value) ?? 0) * 100).round()),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*([.,]\d{0,2})?$')),
            ],
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              prefixText: context.l10n.currencySymbol,
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
