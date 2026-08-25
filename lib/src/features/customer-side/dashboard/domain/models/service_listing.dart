import 'package:aquabook/src/data/models/business_model.dart';

class ServiceListing {
  const ServiceListing({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    this.price,
    this.durationMinutes,
    this.isPromotionActive = false,
  });

  final String id;
  final String name;
  final String location;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final int? price;
  final int? durationMinutes;
  final bool isPromotionActive;

  factory ServiceListing.fromBusiness(BusinessModel business) {
    final primaryOffering = business.serviceDetails?.offerings.firstOrNull;
    return ServiceListing(
      id: business.id,
      name: business.name,
      location: business.location.city.isNotEmpty
          ? business.location.city
          : business.location.address,
      rating: business.averageRating,
      reviewCount: business.reviewCount,
      imageUrl: business.coverPhotoUrl ?? business.logoUrl ?? '',
      price: primaryOffering?.price,
      durationMinutes: primaryOffering?.durationMinutes,
      isPromotionActive: business.isPromotionActive,
    );
  }
}
