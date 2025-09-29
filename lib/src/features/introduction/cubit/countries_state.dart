import 'package:aquabook/src/features/introduction/domain/models/country_model/country_model.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'countries_state.mapper.dart';

@MappableClass()
class CountriesState with CountriesStateMappable {
  final bool isLoading;
  final List<CountryModel> countries;

  CountriesState({this.isLoading = false, this.countries = const []});
}
