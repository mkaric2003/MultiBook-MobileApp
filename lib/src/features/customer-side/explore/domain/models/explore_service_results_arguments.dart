class ExploreServiceResultsArguments {
  const ExploreServiceResultsArguments({
    this.city,
    this.categoryId,
    this.collectionId,
    required this.categoryTitle,
  });

  final String? city;
  final String? categoryId;
  final String? collectionId;
  final String categoryTitle;
}
