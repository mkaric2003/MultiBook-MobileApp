import 'package:aquabook/src/data/enums/currency_code.dart';
import 'package:flutter/widgets.dart';

class LocaleState {
  const LocaleState({required this.locale, required this.currency});

  final Locale locale;
  final CurrencyCode currency;

  LocaleState copyWith({Locale? locale, CurrencyCode? currency}) => LocaleState(
    locale: locale ?? this.locale,
    currency: currency ?? this.currency,
  );
}
