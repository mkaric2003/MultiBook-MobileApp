import 'package:multibook/src/data/enums/service_weekday.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'service_availability_slot_model.mapper.dart';

@MappableClass()
class ServiceAvailabilitySlotModel with ServiceAvailabilitySlotModelMappable {
  const ServiceAvailabilitySlotModel({
    required this.id,
    required this.weekday,
    required this.startMinutes,
    required this.endMinutes,
  });

  final String id;
  final ServiceWeekday weekday;
  final int startMinutes;
  final int endMinutes;
}
