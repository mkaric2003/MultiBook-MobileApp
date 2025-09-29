import 'package:dart_mappable/dart_mappable.dart';

part 'localized_model.mapper.dart';

@MappableClass()
class LocalizedNameModel with LocalizedNameModelMappable {
  final String official;
  final String common;

  LocalizedNameModel({required this.official, required this.common});
}
