import 'package:dart_mappable/dart_mappable.dart';

part 'currency_model.mapper.dart';

@MappableClass()
class CurrencyModel with CurrencyModelMappable {
  final String name;
  final String? symbol;

  CurrencyModel({required this.name, this.symbol});
}
