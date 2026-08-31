import 'dart:developer';

import 'package:multibook/src/data/data_sources/api_client.dart';
import 'package:multibook/src/data/models/service_search_page_model.dart';
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
  ServiceSearchDataSourceImpl(this._client);
  final ApiClient _client;

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
      final response = await _client.get(
        '/v1/services/search',
        queryParameters: {
          if (date != null)
            'appointment_date':
                DateTime.utc(date.year, date.month, date.day)
                    .toIso8601String()
                    .substring(0, 10),
          if (timeMinutes != null) 'start_minutes': timeMinutes,
          if (categoryId?.trim().isNotEmpty ?? false)
            'category_id': categoryId!.trim(),
          if (collectionId?.trim().isNotEmpty ?? false)
            'collection_id': collectionId!.trim(),
          if (city?.trim().isNotEmpty ?? false) 'city': city!.trim(),
          'min_price_minor': (minPrice * 100).round(),
          'max_price_minor': (maxPrice * 100).round(),
          'sort_option': sortOption,
          if (cursor?.isNotEmpty ?? false) 'cursor': cursor,
          'page_size': 8,
        },
      );
      final data = response.data!;
      return ServiceSearchPageModel(
        items: (data['items'] as List? ?? const [])
            .whereType<Map>()
            .map(_map)
            .toList(),
        nextCursor: data['nextCursor'] as String?,
      );
    } catch (error, stackTrace) {
      log(
        'REST service search failed.',
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
