import 'package:aquabook/src/features/customer-side/appointment_payment/domain/models/appointment_payment_arguments.dart';
import 'package:aquabook/src/data/models/appointment_model.dart';

class AppointmentConfirmedArguments {
  const AppointmentConfirmedArguments({
    required this.payment,
    required this.appointment,
  });

  final AppointmentPaymentArguments payment;
  final AppointmentModel appointment;
}
