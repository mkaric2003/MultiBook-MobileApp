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
  });

  final DateTime? checkIn;
  final DateTime? checkOut;
  final int adults;
  final int children;
  final String? city;
  final double minPrice;
  final double maxPrice;
  final double minimumRating;

  int get guestCount => adults + children;

  bool get hasActiveFilters =>
      checkIn != null ||
      checkOut != null ||
      adults > 1 ||
      children > 0 ||
      city != null ||
      minPrice > 50 ||
      maxPrice < 500 ||
      minimumRating > 0;

  int get appliedFiltersCount => [
    if (checkIn != null || checkOut != null) true,
    if (adults > 1 || children > 0) true,
    if (city != null) true,
    if (minPrice > 50 || maxPrice < 500) true,
    if (minimumRating > 0) true,
  ].length;

  StayFilters copyWith({
    DateTime? checkIn,
    DateTime? checkOut,
    int? adults,
    int? children,
    String? city,
    bool clearCity = false,
    bool clearCheckOut = false,
    double? minPrice,
    double? maxPrice,
    double? minimumRating,
  }) {
    return StayFilters(
      checkIn: checkIn ?? this.checkIn,
      checkOut: clearCheckOut ? null : checkOut ?? this.checkOut,
      adults: adults ?? this.adults,
      children: children ?? this.children,
      city: clearCity ? null : city ?? this.city,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minimumRating: minimumRating ?? this.minimumRating,
    );
  }
}
