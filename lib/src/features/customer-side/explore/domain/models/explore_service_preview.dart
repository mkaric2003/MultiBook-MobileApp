class ExploreServicePreview {
  const ExploreServicePreview({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.startingPrice,
  });

  final String name;
  final String category;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final int startingPrice;
}
