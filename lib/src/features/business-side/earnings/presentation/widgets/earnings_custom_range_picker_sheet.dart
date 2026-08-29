import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/business-side/earnings/domain/models/earnings_date_range.dart';
import 'package:multibook/src/features/business-side/earnings/presentation/widgets/earnings_range_date_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EarningsCustomRangePickerSheet extends HookWidget {
  const EarningsCustomRangePickerSheet({required this.initialRange, super.key});

  final EarningsDateRange initialRange;

  @override
  Widget build(BuildContext context) {
    final start = useState(initialRange.start);
    final end = useState(initialRange.end);
    final selectingStart = useState(true);
    final selectedDate = selectingStart.value ? start.value : end.value;

    return Material(
      color: AppColors.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.selectDateRange,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(
                      EarningsDateRange(start: start.value, end: end.value),
                    ),
                    child: Text(context.l10n.done),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  EarningsRangeDateButton(
                    label: context.l10n.startDate,
                    value: start.value,
                    isSelected: selectingStart.value,
                    onTap: () => selectingStart.value = true,
                  ),
                  const SizedBox(width: 12),
                  EarningsRangeDateButton(
                    label: context.l10n.endDate,
                    value: end.value,
                    isSelected: !selectingStart.value,
                    onTap: () => selectingStart.value = false,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 190,
                child: CupertinoTheme(
                  data: const CupertinoThemeData(
                    brightness: Brightness.dark,
                    primaryColor: AppColors.primary,
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    maximumDate: DateTime.now(),
                    initialDateTime: selectedDate,
                    onDateTimeChanged: (value) {
                      final date = DateTime(value.year, value.month, value.day);
                      if (selectingStart.value) {
                        start.value = date;
                        if (date.isAfter(end.value)) end.value = date;
                      } else {
                        end.value = date;
                        if (date.isBefore(start.value)) start.value = date;
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
