import 'package:aquabook/src/features/customer-side/appointment_payment/domain/models/appointment_payment_arguments.dart';

class AppointmentConfirmedArguments {
  AppointmentConfirmedArguments({
    required this.payment,
    required this.paymentMethod,
  }) : confirmationCode =
           '#AP-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';

  final AppointmentPaymentArguments payment;
  final String paymentMethod;
  final String confirmationCode;
}
