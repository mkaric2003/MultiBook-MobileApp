import 'dart:developer';

import 'package:multibook/src/data/models/service_search_page_model.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

abstract class ServiceSearchDataSource {
  Future<ServiceSearchPageModel> search({
    DateTime? date,
    int? timeMinutes,
    String? categoryId,
    String? collectionId,
    String? city,
    required double minPrice,
    required double maxPrice,
    required String sortOption,
    String? cursor,
  });
}

@LazySingleton(as: ServiceSearchDataSource)
class ServiceSearchDataSourceImpl implements ServiceSearchDataSource {
  ServiceSearchDataSourceImpl(this._functions);
  final FirebaseFunctions _functions;

  @override
  Future<ServiceSearchPageModel> search({
    DateTime? date,
    int? timeMinutes,
    String? categoryId,
    String? collectionId,
    String? city,
    required double minPrice,
    required double maxPrice,
    required String sortOption,
    String? cursor,
  }) async {
    try {
      final response = await _functions.httpsCallable('searchServices').call({
        'date': date == null
            ? null
            : DateTime.utc(date.year, date.month, date.day).toIso8601String(),
        'timeMinutes': timeMinutes,
        'categoryId': categoryId,
        'collectionId': collectionId,
        'city': city,
        'minPrice': minPrice,
        'maxPrice': maxPrice,
        'sortOption': sortOption,
        'cursor': cursor,
      });
      final data = Map<String, dynamic>.from(response.data as Map);
      return ServiceSearchPageModel(
        items: (data['items'] as List? ?? const [])
            .whereType<Map>()
            .map(_map)
            .toList(),
        nextCursor: data['nextCursor'] as String?,
      );
    } on FirebaseFunctionsException catch (error, stackTrace) {
      log(
        'Callable service search failed: ${error.code}',
        name: 'ServiceSearchDataSource',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Map<String, dynamic> _map(Map source) => source.map(
    (key, value) => MapEntry(
      key.toString(),
      value is Map
          ? _map(value)
          : value is List
          ? value.map((item) => item is Map ? _map(item) : item).toList()
          : value,
    ),
  );
}
