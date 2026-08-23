import 'package:aquabook/src/data/enums/payment_method_type.dart';

class AppointmentPaymentRequest {
  const AppointmentPaymentRequest({
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.paymentType,
    required this.paymentMethod,
  });

  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final PaymentMethodType paymentType;
  final String paymentMethod;
}
