class AppointmentPaymentRequest {
  const AppointmentPaymentRequest({
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.paymentMethod,
  });

  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String paymentMethod;
}
