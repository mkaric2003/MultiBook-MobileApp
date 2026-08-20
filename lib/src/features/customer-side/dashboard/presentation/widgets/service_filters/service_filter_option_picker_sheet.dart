import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ServiceFilterOptionPickerSheet extends StatelessWidget {
  const ServiceFilterOptionPickerSheet({
    super.key,
    required this.title,
    required this.allOptionLabel,
    required this.options,
    required this.selectedOption,
  });

  final String title;
  final String allOptionLabel;
  final List<String> options;
  final String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 430,
          child: Column(
            children: [
              Container(
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.surfaceHighlight),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(allOptionLabel),
                      trailing: selectedOption == null
                          ? const Icon(
                              Icons.check_rounded,
                              color: AppColors.primary,
                            )
                          : null,
                      onTap: () => Navigator.of(context).pop(''),
                    ),
                    for (final option in options)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(option),
                        trailing: selectedOption == option
                            ? const Icon(
                                Icons.check_rounded,
                                color: AppColors.primary,
                              )
                            : null,
                        onTap: () => Navigator.of(context).pop(option),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
