import 'package:dart_mappable/dart_mappable.dart';

import '../enums/stay_booking_status.dart';

part 'stay_booking_model.mapper.dart';

@MappableClass()
class StayBookingModel with StayBookingModelMappable {
  final String id;

  final String businessId;
  final String userId;

  final DateTime checkIn;
  final DateTime checkOut;

  final int adults;
  final int children;

  final String? unitId;

  final double totalPrice;
  final String currency;

  final StayBookingStatus status;

  final String? note;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const StayBookingModel({
    required this.id,
    required this.businessId,
    required this.userId,
    required this.checkIn,
    required this.checkOut,
    required this.adults,
    this.children = 0,
    this.unitId,
    required this.totalPrice,
    required this.currency,
    this.status = StayBookingStatus.pending,
    this.note,
    this.createdAt,
    this.updatedAt,
  });
}
