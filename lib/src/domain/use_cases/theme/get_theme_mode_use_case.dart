import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:multibook/src/domain/repositories/theme_repository.dart';

@injectable
class GetThemeModeUseCase {
  GetThemeModeUseCase(this._repository);

  final ThemeRepository _repository;

  ThemeMode execute() => _repository.themeMode;
}
