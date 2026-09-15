import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:multibook/src/domain/use_cases/theme/get_theme_mode_use_case.dart';
import 'package:multibook/src/domain/use_cases/theme/set_theme_mode_use_case.dart';
import 'package:multibook/src/features/shared/theme/cubit/theme_state.dart';

@lazySingleton
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(GetThemeModeUseCase getThemeMode, this._setThemeMode)
    : super(ThemeState(getThemeMode.execute()));

  final SetThemeModeUseCase _setThemeMode;

  Future<void> setLightTheme({required bool isLight}) async {
    final themeMode = isLight ? ThemeMode.light : ThemeMode.dark;
    if (themeMode == state.themeMode) return;
    await _setThemeMode.execute(themeMode);
    emit(ThemeState(themeMode));
  }
}
