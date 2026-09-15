import 'package:multibook/src/data/models/appointment_model.dart';

class AppointmentPaymentState {
  const AppointmentPaymentState({
    this.isProcessing = false,
    this.appointment,
    this.errorMessage,
  });

  final bool isProcessing;
  final AppointmentModel? appointment;
  final String? errorMessage;
}
