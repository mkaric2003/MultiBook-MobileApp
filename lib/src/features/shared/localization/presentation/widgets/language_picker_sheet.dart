import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/shared/localization/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguagePickerSheet extends StatelessWidget {
  const LanguagePickerSheet({super.key});

  static Future<void> show(BuildContext context) => showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => const LanguagePickerSheet(),
  );

  @override
  Widget build(BuildContext context) {
    final locale = context.select<LocaleCubit, Locale>(
      (cubit) => cubit.state.locale,
    );
    final options = <({Locale locale, String label})>[
      (locale: const Locale('bs'), label: context.l10n.bosnian),
      (locale: const Locale('en'), label: context.l10n.english),
    ];

    return RadioGroup<Locale>(
      groupValue: locale,
      onChanged: (value) async {
        if (value == null) return;
        await context.read<LocaleCubit>().changeLocale(value);
        if (context.mounted) Navigator.of(context).pop();
      },
      child: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 26),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.selectLanguage,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 14),
              ...options.map(
                (option) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    option.label,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: Radio<Locale>(
                    value: option.locale,
                    activeColor: AppColors.primary,
                  ),
                  onTap: () async {
                    await context.read<LocaleCubit>().changeLocale(
                      option.locale,
                    );
                    if (context.mounted) Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
