import 'package:aquabook/src/data/repositories/locale_repository.dart';
import 'package:aquabook/src/features/shared/localization/cubit/locale_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit(this._localeRepository)
    : super(LocaleState(locale: _localeRepository.locale));

  final LocaleRepository _localeRepository;

  Future<void> changeLocale(Locale locale) async {
    if (locale == state.locale) return;
    await _localeRepository.setLocale(locale);
    emit(state.copyWith(locale: locale));
  }
}
