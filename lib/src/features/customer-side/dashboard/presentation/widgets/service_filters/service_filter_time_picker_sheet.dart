import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ServiceFilterTimePickerSheet extends HookWidget {
  const ServiceFilterTimePickerSheet({super.key, required this.initialMinutes});

  final int initialMinutes;

  @override
  Widget build(BuildContext context) {
    final selectedMinutes = useState(initialMinutes);
    final initialDate = DateTime(
      2020,
      1,
      1,
      initialMinutes ~/ 60,
      initialMinutes % 60,
    );

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
                      context.l10n.selectTime,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () =>
                          Navigator.of(context).pop(selectedMinutes.value),
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
                    mode: CupertinoDatePickerMode.time,
                    minuteInterval: 30,
                    initialDateTime: initialDate,
                    backgroundColor: context.appPalette.surface,
                    onDateTimeChanged: (value) =>
                        selectedMinutes.value = value.hour * 60 + value.minute,
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
