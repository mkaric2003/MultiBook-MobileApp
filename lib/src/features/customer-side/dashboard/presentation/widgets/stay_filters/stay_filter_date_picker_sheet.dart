import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StayFilterDatePickerSheet extends HookWidget {
  const StayFilterDatePickerSheet({
    super.key,
    required this.title,
    required this.initialDate,
    required this.minimumDate,
  });

  final String title;
  final DateTime initialDate;
  final DateTime minimumDate;

  @override
  Widget build(BuildContext context) {
    final effectiveInitialDate = initialDate.isBefore(minimumDate)
        ? minimumDate
        : initialDate;
    final selectedDate = useState(effectiveInitialDate);

    return Material(
      color: AppColors.surface,
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
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.border)),
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
                      title,
                      style: const TextStyle(
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
                  data: const CupertinoThemeData(
                    brightness: Brightness.dark,
                    primaryColor: AppColors.primary,
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(fontSize: 23),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: initialDate,
                    minimumDate: minimumDate,
                    maximumDate: DateTime.now().add(const Duration(days: 730)),
                    backgroundColor: AppColors.surface,
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
