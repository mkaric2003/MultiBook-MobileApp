import 'package:flutter/material.dart';

abstract class ThemeRepository {
  ThemeMode get themeMode;

  Future<void> setThemeMode(ThemeMode themeMode);
}
