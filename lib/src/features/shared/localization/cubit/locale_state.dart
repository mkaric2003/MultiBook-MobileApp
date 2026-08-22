import 'package:flutter/widgets.dart';

class LocaleState {
  const LocaleState({required this.locale});

  final Locale locale;

  LocaleState copyWith({Locale? locale}) =>
      LocaleState(locale: locale ?? this.locale);
}
