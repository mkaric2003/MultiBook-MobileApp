import 'package:aquabook/src/data/models/business_model.dart';

class StayListing {
  const StayListing({
    required this.id,
    required this.name,
    required this.location,
    this.pricePerNight,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    this.isFeatured = false,
  });

  final String id;
  final String name;
  final String location;
  final int? pricePerNight;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final bool isFeatured;

  factory StayListing.fromBusiness(BusinessModel business) {
    return StayListing(
      id: business.id,
      name: business.name,
      location: business.location.city.isNotEmpty
          ? business.location.city
          : business.location.address,
      pricePerNight: business.stayDetails?.pricePerNight,
      rating: business.averageRating,
      reviewCount: business.reviewCount,
      imageUrl: business.coverPhotoUrl ?? business.logoUrl ?? '',
    );
  }
}
