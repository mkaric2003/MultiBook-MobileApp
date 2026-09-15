enum ServiceSortOption { recommended, priceLowToHigh, priceHighToLow, rating }

extension ServiceSortOptionLabel on ServiceSortOption {
  String get label => switch (this) {
    ServiceSortOption.recommended => 'Recommended',
    ServiceSortOption.priceLowToHigh => 'Price: low to high',
    ServiceSortOption.priceHighToLow => 'Price: high to low',
    ServiceSortOption.rating => 'Highest rated',
  };
}
