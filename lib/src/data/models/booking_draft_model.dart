import 'package:aquabook/src/data/models/stay_extra_model.dart';

class BookingDraftModel {
  const BookingDraftModel({
    required this.id,
    required this.businessId,
    required this.businessName,
    required this.businessLocation,
    required this.businessImageUrl,
    required this.pricePerNight,
    required this.checkIn,
    required this.checkOut,
    required this.adults,
    required this.children,
    required this.infants,
    this.roomTypeId,
    this.selectedExtras = const [],
  });
  final String id;
  final String businessId;
  final String businessName;
  final String businessLocation;
  final String businessImageUrl;
  final int pricePerNight;
  final DateTime checkIn;
  final DateTime checkOut;
  final int adults;
  final int children;
  final int infants;
  final String? roomTypeId;
  final List<StayExtraModel> selectedExtras;
}
