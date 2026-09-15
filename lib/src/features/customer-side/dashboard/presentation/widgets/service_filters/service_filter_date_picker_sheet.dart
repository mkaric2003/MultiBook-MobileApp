import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ServiceFilterDatePickerSheet extends HookWidget {
  const ServiceFilterDatePickerSheet({super.key, required this.initialDate});

  final DateTime initialDate;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final effectiveInitialDate = initialDate.isBefore(today)
        ? today
        : initialDate;
    final selectedDate = useState(effectiveInitialDate);

    return Material(
      color: context.appPalette.surface,
      child: SafeArea(
        top: false,
        bottom: false,
        child: SizedBox(
          width: double.infinity,
          height: 350,
          child: Column(
            children: [
              Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: context.appPalette.border),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(context.l10n.cancel),
                    ),
                    Text(
                      context.l10n.selectDate,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () =>
                          Navigator.of(context).pop(selectedDate.value),
                      child: Text(
                        context.l10n.done,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    brightness: Theme.of(context).brightness,
                    primaryColor: AppColors.primary,
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: effectiveInitialDate,
                    minimumDate: today,
                    maximumDate: today.add(const Duration(days: 730)),
                    backgroundColor: context.appPalette.surface,
                    onDateTimeChanged: (value) => selectedDate.value = value,
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
