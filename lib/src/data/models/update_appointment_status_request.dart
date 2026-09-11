import 'package:dart_mappable/dart_mappable.dart';

part 'update_appointment_status_request.mapper.dart';

@MappableClass()
class UpdateAppointmentStatusRequest
    with UpdateAppointmentStatusRequestMappable {
  const UpdateAppointmentStatusRequest({required this.status});

  final String status;
}
