import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/business-side/earnings/domain/enums/earnings_period.dart';
import 'package:flutter/material.dart';

class EarningsPeriodSelector extends StatelessWidget {
  const EarningsPeriodSelector({
    required this.period,
    required this.onSelected,
    super.key,
  });

  final EarningsPeriod period;
  final ValueChanged<EarningsPeriod> onSelected;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 14),
    decoration: BoxDecoration(
      color: context.appPalette.surface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: context.appPalette.border),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<EarningsPeriod>(
        value: period,
        isExpanded: true,
        dropdownColor: context.appPalette.surface,
        icon: Icon(Icons.keyboard_arrow_down, color: context.appPalette.muted),
        style: TextStyle(
          color: context.appPalette.foreground,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        items: EarningsPeriod.values
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(_label(context, item)),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value != null) onSelected(value);
        },
      ),
    ),
  );

  String _label(BuildContext context, EarningsPeriod value) => switch (value) {
    EarningsPeriod.currentWeek => context.l10n.currentWeek,
    EarningsPeriod.previousWeek => context.l10n.previousWeek,
    EarningsPeriod.currentMonth => context.l10n.currentMonth,
    EarningsPeriod.previousMonth => context.l10n.previousMonth,
    EarningsPeriod.currentYear => context.l10n.currentYear,
    EarningsPeriod.previousYear => context.l10n.previousYear,
    EarningsPeriod.custom => context.l10n.customRange,
  };
}
