import 'package:dart_mappable/dart_mappable.dart';

part 'reschedule_appointment_request.mapper.dart';

@MappableClass()
class RescheduleAppointmentRequest with RescheduleAppointmentRequestMappable {
  const RescheduleAppointmentRequest({
    required this.appointmentDate,
    required this.startMinutes,
  });

  @MappableField(key: 'appointment_date')
  final String appointmentDate;

  @MappableField(key: 'start_minutes')
  final int startMinutes;
}
