import 'package:dart_mappable/dart_mappable.dart';

part 'service_offering_model.mapper.dart';

@MappableClass()
class ServiceOfferingModel with ServiceOfferingModelMappable {
  const ServiceOfferingModel({
    required this.id,
    required this.name,
    required this.durationMinutes,
    required this.price,
    this.description,
    this.isActive = true,
  });

  final String id;
  final String name;
  final int durationMinutes;
  final int price;
  final String? description;
  final bool isActive;
}
