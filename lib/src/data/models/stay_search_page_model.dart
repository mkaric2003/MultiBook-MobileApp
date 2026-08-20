class StaySearchPageModel {
  const StaySearchPageModel({required this.items, required this.nextCursor});

  final List<Map<String, dynamic>> items;
  final String? nextCursor;
}
