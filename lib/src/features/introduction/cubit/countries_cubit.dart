import 'dart:developer';

import 'package:aquabook/src/features/data/repositories/country_repository.dart';
import 'package:aquabook/src/features/introduction/cubit/countries_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountriesCubit extends Cubit<CountriesState> {
  final CountryRepository _countryRepository = CountryRepository();
  CountriesCubit() : super(CountriesState()) {
    initialize();
  }

  Future<void> initialize() async {
    await fetchCountries();
  }

  Future<void> fetchCountries() async {
    emit(CountriesState(isLoading: true, countries: state.countries));
    try {
      final countries = await _countryRepository.fetchAll();
      log('Countries length: ${countries?.length}');
      emit(CountriesState(isLoading: false, countries: countries ?? []));
    } catch (e) {
      emit(CountriesState(isLoading: false, countries: state.countries));
    }
  }

  Future<void> searchCountries(String query) async {
    if (query.trim().isEmpty) {
      await fetchCountries();
      return;
    }

    emit(CountriesState(isLoading: true, countries: state.countries));
    try {
      final countries = await _countryRepository.searchByName(query);
      log('Searched Countries length: ${countries?.length}');
      emit(CountriesState(isLoading: false, countries: countries ?? []));
    } catch (e) {
      emit(CountriesState(isLoading: false, countries: state.countries));
    }
  }
}
