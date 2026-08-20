import 'dart:developer';

import 'package:aquabook/src/data/models/stay_search_page_model.dart';
import 'package:cloud_functions/cloud_functions.dart';
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
    required List<String> amenities,
    String? inventoryType,
    String? cursor,
    int pageSize = 8,
  });
}

@LazySingleton(as: StaySearchDataSource)
class StaySearchDataSourceImpl implements StaySearchDataSource {
  StaySearchDataSourceImpl(this._functions);

  final FirebaseFunctions _functions;

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
    required List<String> amenities,
    String? inventoryType,
    String? cursor,
    int pageSize = 8,
  }) async {
    try {
      final response = await _functions.httpsCallable('searchStays').call({
        'city': city,
        'checkIn': checkIn == null
            ? null
            : _asUtcDate(checkIn).toIso8601String(),
        'checkOut': checkOut == null
            ? null
            : _asUtcDate(checkOut).toIso8601String(),
        'adults': adults,
        'children': children,
        'minPrice': minPrice,
        'maxPrice': maxPrice,
        'minimumRating': minimumRating,
        'categoryIds': categoryIds,
        'amenities': amenities,
        'inventoryType': inventoryType,
        'cursor': cursor,
        'pageSize': pageSize,
      });
      final data = Map<String, dynamic>.from(response.data as Map);
      return StaySearchPageModel(
        items: (data['items'] as List? ?? const [])
            .whereType<Map>()
            .map((item) => _toStringDynamicMap(item))
            .toList(),
        nextCursor: data['nextCursor'] as String?,
      );
    } on FirebaseFunctionsException catch (error, stackTrace) {
      log(
        'Callable stay search failed: ${error.code}',
        name: 'StaySearchDataSource',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
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
