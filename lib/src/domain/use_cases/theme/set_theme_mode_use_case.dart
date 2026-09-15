import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:multibook/src/domain/repositories/theme_repository.dart';

@injectable
class SetThemeModeUseCase {
  SetThemeModeUseCase(this._repository);

  final ThemeRepository _repository;

  Future<void> execute(ThemeMode themeMode) =>
      _repository.setThemeMode(themeMode);
}
