import 'package:dart_mappable/dart_mappable.dart';

import 'service_availability_slot_model.dart';
import 'service_offering_model.dart';
import 'service_provider_model.dart';

part 'service_details_model.mapper.dart';

@MappableClass()
class ServiceDetailsModel with ServiceDetailsModelMappable {
  const ServiceDetailsModel({
    this.offerings = const [],
    this.availabilitySlots = const [],
    this.provider,
  });

  final List<ServiceOfferingModel> offerings;
  final List<ServiceAvailabilitySlotModel> availabilitySlots;
  final ServiceProviderModel? provider;
}
