class ExploreStayResultsArguments {
  const ExploreStayResultsArguments({
    required this.city,
    required this.categoryId,
    required this.categoryTitle,
    this.collectionId,
  });

  final String city;
  final String categoryId;
  final String categoryTitle;
  final String? collectionId;
}
