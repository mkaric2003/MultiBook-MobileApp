import 'package:dart_mappable/dart_mappable.dart';

part 'available_appointment_slots_model.mapper.dart';

@MappableClass()
class AvailableAppointmentSlotsModel
    with AvailableAppointmentSlotsModelMappable {
  const AvailableAppointmentSlotsModel({
    required this.staffId,
    required this.appointmentDate,
    required this.durationMinutes,
    required this.startMinutes,
  });

  @MappableField(key: 'staff_id')
  final String staffId;

  @MappableField(key: 'appointment_date')
  final String appointmentDate;

  @MappableField(key: 'duration_minutes')
  final int durationMinutes;

  @MappableField(key: 'start_minutes')
  final List<int> startMinutes;
}
