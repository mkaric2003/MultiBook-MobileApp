import 'package:multibook/src/data/models/stay_search_page_model.dart';
import 'package:multibook/src/core/networking/api_client.dart';
import 'package:injectable/injectable.dart';

abstract class StaySearchDataSource {
  Future<StaySearchPageModel> search({
    String? city,
    DateTime? checkIn,
    DateTime? checkOut,
    required int adults,
    required int children,
    required double minPrice,
    required double maxPrice,
    required double minimumRating,
    required List<String> categoryIds,
    required List<String> collectionIds,
    required List<String> amenities,
    String? inventoryType,
    String? cursor,
    int pageSize = 8,
  });
}

@LazySingleton(as: StaySearchDataSource)
class StaySearchDataSourceImpl implements StaySearchDataSource {
  StaySearchDataSourceImpl(this._client);

  final ApiClient _client;

  static const _defaultAdults = 1;
  static const _defaultChildren = 0;
  static const _defaultMinPrice = 50.0;
  static const _defaultMaxPrice = 500.0;
  static const _defaultMinimumRating = 0.0;

  @override
  Future<StaySearchPageModel> search({
    String? city,
    DateTime? checkIn,
    DateTime? checkOut,
    required int adults,
    required int children,
    required double minPrice,
    required double maxPrice,
    required double minimumRating,
    required List<String> categoryIds,
    required List<String> collectionIds,
    required List<String> amenities,
    String? inventoryType,
    String? cursor,
    int pageSize = 8,
  }) async {
    final response = await _client.get(
      '/v1/stays/search',
      queryParameters: {
        if (city?.trim().isNotEmpty ?? false) 'city': city!.trim(),
        if (checkIn != null) 'check_in': _asUtcDate(checkIn).toIso8601String(),
        if (checkOut != null)
          'check_out': _asUtcDate(checkOut).toIso8601String(),
        if (adults != _defaultAdults) 'adults': adults,
        if (children != _defaultChildren) 'children': children,
        if (minPrice != _defaultMinPrice)
          'min_price_minor': (minPrice * 100).round(),
        if (maxPrice != _defaultMaxPrice)
          'max_price_minor': (maxPrice * 100).round(),
        if (minimumRating != _defaultMinimumRating)
          'minimum_rating': minimumRating,
        if (categoryIds.isNotEmpty) 'category_id': categoryIds,
        if (collectionIds.isNotEmpty) 'collection_id': collectionIds,
        if (amenities.isNotEmpty) 'amenity': amenities,
        if (inventoryType != null) 'inventory_type': inventoryType,
        if (cursor != null) 'offset': cursor,
        'page_size': pageSize,
      },
    );
    final data = response.data!;
    return StaySearchPageModel(
      items: (data['items'] as List? ?? const [])
          .whereType<Map>()
          .map(_toStringDynamicMap)
          .toList(),
      nextCursor: data['nextCursor'] as String?,
    );
  }

  Map<String, dynamic> _toStringDynamicMap(Map source) {
    return source.map(
      (key, value) => MapEntry(
        key.toString(),
        value is Map
            ? _toStringDynamicMap(value)
            : value is List
            ? value
                  .map((item) => item is Map ? _toStringDynamicMap(item) : item)
                  .toList()
            : value,
      ),
    );
  }

  DateTime _asUtcDate(DateTime value) =>
      DateTime.utc(value.year, value.month, value.day);
}
