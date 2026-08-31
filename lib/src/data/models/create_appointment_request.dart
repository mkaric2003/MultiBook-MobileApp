import 'package:dart_mappable/dart_mappable.dart';

part 'create_appointment_request.mapper.dart';

@MappableClass()
class CreateAppointmentRequest with CreateAppointmentRequestMappable {
  const CreateAppointmentRequest({
    required this.staffId,
    required this.appointmentDate,
    required this.startMinutes,
    required this.offeringIds,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.paymentMethod,
  });

  @MappableField(key: 'staff_id')
  final String staffId;
  @MappableField(key: 'appointment_date')
  final String appointmentDate;
  @MappableField(key: 'start_minutes')
  final int startMinutes;
  @MappableField(key: 'offering_ids')
  final List<String> offeringIds;
  @MappableField(key: 'customer_name')
  final String customerName;
  @MappableField(key: 'customer_email')
  final String customerEmail;
  @MappableField(key: 'customer_phone')
  final String customerPhone;
  @MappableField(key: 'payment_method')
  final String paymentMethod;
}
