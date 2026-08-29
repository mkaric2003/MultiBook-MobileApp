import 'package:multibook/src/data/models/appointment_model.dart';

class RescheduleAppointmentState {
  const RescheduleAppointmentState({
    this.isSubmitting = false,
    this.appointment,
    this.errorMessage,
  });

  final bool isSubmitting;
  final AppointmentModel? appointment;
  final String? errorMessage;
}
