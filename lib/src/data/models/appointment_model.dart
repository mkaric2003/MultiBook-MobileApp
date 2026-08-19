class AppointmentModel {
  const AppointmentModel({
    required this.id,
    required this.businessId,
    required this.businessOwnerId,
    required this.businessName,
    required this.businessImageUrl,
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
    this.status = 'confirmed',
    this.rescheduleCount = 0,
  });

  final String id;
  final String businessId;
  final String businessOwnerId;
  final String businessName;
  final String businessImageUrl;
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
  final String status;
  final int rescheduleCount;

  AppointmentModel copyWith({
    String? businessName,
    String? businessImageUrl,
    String? status,
    DateTime? date,
    int? startMinutes,
    int? endMinutes,
    int? rescheduleCount,
  }) => AppointmentModel(
    id: id,
    businessId: businessId,
    businessOwnerId: businessOwnerId,
    businessName: businessName ?? this.businessName,
    businessImageUrl: businessImageUrl ?? this.businessImageUrl,
    customerId: customerId,
    customerName: customerName,
    customerEmail: customerEmail,
    customerPhone: customerPhone,
    providerId: providerId,
    providerName: providerName,
    serviceIds: serviceIds,
    serviceNames: serviceNames,
    date: date ?? this.date,
    startMinutes: startMinutes ?? this.startMinutes,
    endMinutes: endMinutes ?? this.endMinutes,
    serviceCost: serviceCost,
    addOnsCost: addOnsCost,
    serviceFee: serviceFee,
    taxes: taxes,
    total: total,
    paymentMethod: paymentMethod,
    confirmationCode: confirmationCode,
    status: status ?? this.status,
    rescheduleCount: rescheduleCount ?? this.rescheduleCount,
  );
}
