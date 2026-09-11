import 'package:multibook/src/data/enums/currency_code.dart';
import 'package:multibook/src/data/enums/payment_status.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'appointment_model.mapper.dart';

@MappableClass()
class AppointmentModel with AppointmentModelMappable {
  static AppointmentModel fromMap(Map<String, dynamic> map) =>
      AppointmentModelMapper.fromMap(map);

  static AppointmentModel fromJson(String json) =>
      AppointmentModelMapper.fromJson(json);
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
    this.customerAvatarUrl,
    required this.providerId,
    required this.providerName,
    this.providerCommissionRate = 100,
    this.providerEarnings = 0,
    required this.serviceIds,
    required this.serviceNames,
    required this.date,
    required this.startMinutes,
    required this.endMinutes,
    required this.serviceCost,
    this.originalServiceCost = 0,
    this.discountAmount = 0,
    required this.addOnsCost,
    required this.serviceFee,
    required this.taxes,
    required this.total,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.confirmationCode,
    this.currency = CurrencyCode.bam,
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
  final String? customerAvatarUrl;
  final String providerId;
  final String providerName;
  final double providerCommissionRate;
  final double providerEarnings;
  final List<String> serviceIds;
  final List<String> serviceNames;
  final DateTime date;
  final int startMinutes;
  final int endMinutes;
  final int serviceCost;
  final int originalServiceCost;
  final int discountAmount;
  final int addOnsCost;
  final double serviceFee;
  final double taxes;
  final double total;
  final PaymentStatus paymentStatus;
  final String paymentMethod;
  final String confirmationCode;
  final CurrencyCode currency;
  final String status;
  final int rescheduleCount;
}
