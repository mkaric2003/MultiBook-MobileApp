import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/models/business_model.dart';

class RescheduleAppointmentArguments {
  const RescheduleAppointmentArguments({
    required this.appointment,
    required this.business,
  });

  final AppointmentModel appointment;
  final BusinessModel business;
}
