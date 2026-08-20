import 'package:dart_mappable/dart_mappable.dart';

import '../enums/business_type.dart';
import 'business_location_model.dart';
import 'service_details_model.dart';
import 'stay_details_model.dart';

part 'business_model.mapper.dart';

@MappableClass()
class BusinessModel with BusinessModelMappable {
  final String id;
  final String ownerId;

  final BusinessType type;

  final String name;
  final String categoryId;

  final BusinessLocationModel location;

  final String? shortDescription;

  final String? logoUrl;
  final String? coverPhotoUrl;
  final List<String> photoUrls;
  final List<String> featuredCollectionIds;

  final bool isActive;
  final double averageRating;
  final int reviewCount;
  final StayDetailsModel? stayDetails;
  final ServiceDetailsModel? serviceDetails;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BusinessModel({
    required this.id,
    required this.ownerId,
    required this.type,
    required this.name,
    required this.categoryId,
    required this.location,
    this.shortDescription,
    this.logoUrl,
    this.coverPhotoUrl,
    this.photoUrls = const [],
    this.featuredCollectionIds = const [],
    this.isActive = true,
    this.averageRating = 0,
    this.reviewCount = 0,
    this.stayDetails,
    this.serviceDetails,
    this.createdAt,
    this.updatedAt,
  });
}
