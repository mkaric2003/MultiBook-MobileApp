import 'package:dart_mappable/dart_mappable.dart';

import '../enums/business_type.dart';

part 'business_category_model.mapper.dart';

@MappableClass()
class BusinessCategoryModel with BusinessCategoryModelMappable {
  final String id;
  final String name;
  final BusinessType type;

  const BusinessCategoryModel({
    required this.id,
    required this.name,
    required this.type,
  });
}
