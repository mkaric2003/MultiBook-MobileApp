import 'package:aquabook/src/data/enums/booking_status.dart';
import 'package:aquabook/src/data/enums/payment_status.dart';
import 'package:aquabook/src/data/models/stay_extra_model.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'booking_model.mapper.dart';

@MappableClass()
class BookingModel with BookingModelMappable {
  const BookingModel({
    required this.id,
    required this.businessId,
    required this.businessOwnerId,
    required this.customerId,
    required this.customerName,
    required this.customerEmail,
    required this.businessName,
    required this.businessCity,
    required this.businessImageUrl,
    required this.checkIn,
    required this.checkOut,
    required this.adults,
    required this.children,
    required this.infants,
    required this.pricePerNight,
    required this.selectedExtras,
    required this.roomSubtotal,
    required this.cleaningFee,
    required this.serviceFee,
    required this.taxes,
    required this.total,
    required this.status,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.confirmationCode,
    this.roomType,
    this.customerAvatarUrl,
    this.createdAt,
  });
  final String id;
  final String businessId;
  final String businessOwnerId;
  final String customerId;
  final String customerName;
  final String customerEmail;
  final String businessName;
  final String businessCity;
  final String businessImageUrl;
  final DateTime checkIn;
  final DateTime checkOut;
  final int adults;
  final int children;
  final int infants;
  final int pricePerNight;
  final List<StayExtraModel> selectedExtras;
  final int roomSubtotal;
  final int cleaningFee;
  final int serviceFee;
  final int taxes;
  final int total;
  final BookingStatus status;
  final PaymentStatus paymentStatus;
  final String paymentMethod;
  final String confirmationCode;
  final String? roomType;
  final String? customerAvatarUrl;
  final DateTime? createdAt;
}
