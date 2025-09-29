import 'package:aquabook/src/features/introduction/domain/models/localized_name_model/localized_model.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'country_name_model.mapper.dart';

@MappableClass()
class CountryNameModel with CountryNameModelMappable {
  final String common;
  final String official;
  final Map<String, LocalizedNameModel>? nativeName;

  CountryNameModel({
    required this.common,
    required this.official,
    this.nativeName,
  });
}
