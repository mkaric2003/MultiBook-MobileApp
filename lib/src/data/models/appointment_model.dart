class AppointmentModel {
  const AppointmentModel({
    required this.id,
    required this.businessId,
    required this.businessOwnerId,
    required this.customerId,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.providerId,
    required this.providerName,
    required this.serviceIds,
    required this.serviceNames,
    required this.date,
    required this.startMinutes,
    required this.endMinutes,
    required this.serviceCost,
    required this.addOnsCost,
    required this.serviceFee,
    required this.taxes,
    required this.total,
    required this.paymentMethod,
    required this.confirmationCode,
  });

  final String id;
  final String businessId;
  final String businessOwnerId;
  final String customerId;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String providerId;
  final String providerName;
  final List<String> serviceIds;
  final List<String> serviceNames;
  final DateTime date;
  final int startMinutes;
  final int endMinutes;
  final int serviceCost;
  final int addOnsCost;
  final double serviceFee;
  final double taxes;
  final double total;
  final String paymentMethod;
  final String confirmationCode;
}
