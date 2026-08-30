import 'package:dart_mappable/dart_mappable.dart';

import '../enums/business_type.dart';
import '../enums/currency_code.dart';
import 'business_location_model.dart';
import 'service_details_model.dart';
import 'stay_details_model.dart';

part 'business_model.mapper.dart';

@MappableClass()
class BusinessModel with BusinessModelMappable {
  static BusinessModel fromMap(Map<String, dynamic> map) =>
      BusinessModelMapper.fromMap(map);

  static BusinessModel fromJson(String json) =>
      BusinessModelMapper.fromJson(json);

  final String id;
  final String ownerId;

  final BusinessType type;

  final String name;
  final String categoryId;

  final BusinessLocationModel location;
  final CurrencyCode currency;

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
  final bool isPromotionActive;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BusinessModel({
    required this.id,
    required this.ownerId,
    required this.type,
    required this.name,
    required this.categoryId,
    required this.location,
    this.currency = CurrencyCode.bam,
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
    this.isPromotionActive = false,
    this.createdAt,
    this.updatedAt,
  });
}
