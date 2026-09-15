import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:multibook/src/domain/repositories/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: ThemeRepository)
class ThemeRepositoryImpl implements ThemeRepository {
  ThemeRepositoryImpl(this._preferences);

  static const _themeModeKey = 'selected_theme_mode';

  final SharedPreferences _preferences;

  @override
  ThemeMode get themeMode => _preferences.getString(_themeModeKey) == 'light'
      ? ThemeMode.light
      : ThemeMode.dark;

  @override
  Future<void> setThemeMode(ThemeMode themeMode) =>
      _preferences.setString(_themeModeKey, themeMode.name);
}
