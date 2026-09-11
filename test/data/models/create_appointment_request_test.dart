import 'package:flutter_test/flutter_test.dart';
import 'package:multibook/src/data/models/create_appointment_request.dart';

void main() {
  test('encodes the explicitly selected staff id', () {
    const selectedStaffId = 'b9b63a6d-858a-48eb-a7c1-902eca000861';
    const request = CreateAppointmentRequest(
      staffId: selectedStaffId,
      appointmentDate: '2026-09-07',
      startMinutes: 600,
      offeringIds: ['offering-id'],
      customerName: 'Customer',
      customerEmail: 'customer@example.com',
      customerPhone: '+38761123456',
      paymentMethod: 'cash',
    );

    expect(request.toMap()['staff_id'], selectedStaffId);
  });
}
