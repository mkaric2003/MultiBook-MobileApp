import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PromotionDatePickerSheet extends HookWidget {
  const PromotionDatePickerSheet({
    required this.title,
    required this.initialDate,
    required this.minimumDate,
    super.key,
  });

  final String title;
  final DateTime initialDate;
  final DateTime minimumDate;

  @override
  Widget build(BuildContext context) {
    final selectedDate = useState(
      initialDate.isBefore(minimumDate) ? minimumDate : initialDate,
    );
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
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () =>
                          Navigator.of(context).pop(selectedDate.value),
                      child: Text(context.l10n.done),
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
                    initialDateTime: selectedDate.value,
                    minimumDate: minimumDate,
                    maximumDate: DateTime.now().add(const Duration(days: 730)),
                    backgroundColor: AppColors.surface,
                    onDateTimeChanged: (date) => selectedDate.value = date,
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
