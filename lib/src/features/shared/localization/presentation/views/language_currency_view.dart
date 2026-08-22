import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/currency_code.dart';
import 'package:aquabook/src/features/shared/localization/cubit/locale_cubit.dart';
import 'package:aquabook/src/features/shared/localization/presentation/widgets/language_option.dart';
import 'package:aquabook/src/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCurrencyView extends StatelessWidget {
  const LanguageCurrencyView({super.key});

  static const _languages = <({String countryCode, String localeCode})>[
    (countryCode: 'ba', localeCode: 'bs'),
    (countryCode: 'gb', localeCode: 'en'),
    (countryCode: 'de', localeCode: 'de'),
    (countryCode: 'es', localeCode: 'es'),
    (countryCode: 'fr', localeCode: 'fr'),
    (countryCode: 'it', localeCode: 'it'),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedLocale = context.select<LocaleCubit, Locale>(
      (cubit) => cubit.state.locale,
    );
    final selectedCurrency = context.select<LocaleCubit, CurrencyCode>(
      (cubit) => cubit.state.currency,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: context.l10n.languageAndCurrency),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 30, 24, 32),
                children: [
                  Text(
                    context.l10n.selectLanguage,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 18),
                  ..._languages.map(
                    (language) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: LanguageOption(
                        flagCode: language.countryCode,
                        label: _languageLabel(context, language.localeCode),
                        isSelected:
                            selectedLocale.languageCode == language.localeCode,
                        onTap: () => context.read<LocaleCubit>().changeLocale(
                          Locale(language.localeCode),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    context.l10n.currency,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 18),
                  DropdownButtonFormField<CurrencyCode>(
                    initialValue: selectedCurrency,
                    isExpanded: true,
                    dropdownColor: AppColors.surface,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.surface,
                    ),
                    items: CurrencyCode.values
                        .map(
                          (currency) => DropdownMenuItem(
                            value: currency,
                            child: Text(
                              '${currency.code} (${currency.symbol})',
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (currency) {
                      if (currency != null) {
                        context.read<LocaleCubit>().changeCurrency(currency);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _languageLabel(BuildContext context, String localeCode) =>
      switch (localeCode) {
        'bs' => context.l10n.bosnian,
        'en' => context.l10n.english,
        'de' => context.l10n.german,
        'es' => context.l10n.spanish,
        'fr' => context.l10n.french,
        'it' => context.l10n.italian,
        _ => localeCode,
      };
}
