import 'package:aquabook/src/features/introduction/domain/models/country_name_model/country_name_model.dart';
import 'package:aquabook/src/features/introduction/domain/models/currency_model/currency_model.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'country_model.mapper.dart';

@MappableClass()
class CountryModel with CountryModelMappable {
  final CountryNameModel name;
  final List<String>? capital;
  final double? area;
  final Map<String, CurrencyModel>? currencies;
  final Map<String, String>? languages;

  CountryModel({
    required this.name,
    this.capital,
    this.area,
    this.currencies,
    this.languages,
  });
}
