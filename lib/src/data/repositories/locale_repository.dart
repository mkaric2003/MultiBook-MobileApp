import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class LocaleRepository {
  LocaleRepository(this._sharedPreferences);

  static const _localeCodeKey = 'selected_locale_code';
  static const defaultLocale = Locale('bs');
  static const supportedLocaleCodes = {'bs', 'en', 'de', 'es', 'fr', 'it'};

  final SharedPreferences _sharedPreferences;

  Locale get locale {
    final code = _sharedPreferences.getString(_localeCodeKey);
    return supportedLocaleCodes.contains(code) ? Locale(code!) : defaultLocale;
  }

  Future<void> setLocale(Locale locale) {
    if (!supportedLocaleCodes.contains(locale.languageCode)) {
      throw ArgumentError.value(
        locale.languageCode,
        'locale',
        'Unsupported application locale.',
      );
    }
    return _sharedPreferences.setString(_localeCodeKey, locale.languageCode);
  }
}
