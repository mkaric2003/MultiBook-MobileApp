import 'package:flutter/material.dart';

class ThemeState {
  const ThemeState(this.themeMode);

  final ThemeMode themeMode;

  bool get isLight => themeMode == ThemeMode.light;
}
