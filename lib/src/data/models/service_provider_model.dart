import 'package:dart_mappable/dart_mappable.dart';

import 'service_availability_slot_model.dart';

part 'service_provider_model.mapper.dart';

@MappableClass()
class ServiceProviderModel with ServiceProviderModelMappable {
  const ServiceProviderModel({
    required this.id,
    required this.name,
    this.title,
    this.commissionRate = 100,
    this.availabilitySlots = const [],
    this.isActive = true,
  });

  final String id;
  final String name;
  final String? title;
  final double commissionRate;
  final List<ServiceAvailabilitySlotModel> availabilitySlots;
  final bool isActive;
}
