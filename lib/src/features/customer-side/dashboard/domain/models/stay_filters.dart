import 'package:multibook/src/data/enums/stay_amenity.dart';
import 'package:multibook/src/data/enums/stay_inventory_type.dart';

class StayFilters {
  const StayFilters({
    this.checkIn,
    this.checkOut,
    this.adults = 1,
    this.children = 0,
    this.city,
    this.minPrice = 50,
    this.maxPrice = 500,
    this.minimumRating = 0,
    this.categoryIds = const [],
    this.collectionIds = const [],
    this.amenities = const [],
    this.inventoryType,
  });

  final DateTime? checkIn;
  final DateTime? checkOut;
  final int adults;
  final int children;
  final String? city;
  final double minPrice;
  final double maxPrice;
  final double minimumRating;
  final List<String> categoryIds;
  final List<String> collectionIds;
  final List<StayAmenity> amenities;
  final StayInventoryType? inventoryType;

  int get guestCount => adults + children;

  bool get hasActiveFilters =>
      checkIn != null ||
      checkOut != null ||
      adults > 1 ||
      children > 0 ||
      city != null ||
      minPrice > 50 ||
      maxPrice < 500 ||
      minimumRating > 0 ||
      categoryIds.isNotEmpty ||
      collectionIds.isNotEmpty ||
      amenities.isNotEmpty ||
      inventoryType != null;

  int get appliedFiltersCount => [
    if (checkIn != null || checkOut != null) true,
    if (adults > 1 || children > 0) true,
    if (city != null) true,
    if (minPrice > 50 || maxPrice < 500) true,
    if (minimumRating > 0) true,
    if (categoryIds.isNotEmpty) true,
    if (collectionIds.isNotEmpty) true,
    if (amenities.isNotEmpty) true,
    if (inventoryType != null) true,
  ].length;

  StayFilters copyWith({
    DateTime? checkIn,
    DateTime? checkOut,
    int? adults,
    int? children,
    String? city,
    bool clearCity = false,
    bool clearCheckIn = false,
    bool clearCheckOut = false,
    double? minPrice,
    double? maxPrice,
    double? minimumRating,
    List<String>? categoryIds,
    List<String>? collectionIds,
    List<StayAmenity>? amenities,
    StayInventoryType? inventoryType,
    bool clearInventoryType = false,
  }) {
    return StayFilters(
      checkIn: clearCheckIn ? null : checkIn ?? this.checkIn,
      checkOut: clearCheckOut ? null : checkOut ?? this.checkOut,
      adults: adults ?? this.adults,
      children: children ?? this.children,
      city: clearCity ? null : city ?? this.city,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minimumRating: minimumRating ?? this.minimumRating,
      categoryIds: categoryIds ?? this.categoryIds,
      collectionIds: collectionIds ?? this.collectionIds,
      amenities: amenities ?? this.amenities,
      inventoryType: clearInventoryType
          ? null
          : inventoryType ?? this.inventoryType,
    );
  }
}
