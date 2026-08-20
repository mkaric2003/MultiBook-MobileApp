import 'package:aquabook/src/core/theme/app_colors.dart';
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
                      child: const Text('Cancel'),
                    ),
                    const Text(
                      'Select time',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () =>
                          Navigator.of(context).pop(selectedMinutes.value),
                      child: const Text(
                        'Done',
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
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    minuteInterval: 30,
                    initialDateTime: initialDate,
                    backgroundColor: AppColors.surface,
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
