import 'dart:developer';

import 'package:aquabook/src/data/models/business_location_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class NominatimDataSource {
  Future<BusinessLocationModel?> reverseGeocode({
    required double latitude,
    required double longitude,
  });
}

@LazySingleton(as: NominatimDataSource)
class NominatimDataSourceImpl implements NominatimDataSource {
  NominatimDataSourceImpl()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://nominatim.openstreetmap.org',
          headers: const {
            'Accept': 'application/json',
            'User-Agent': 'MultiBook/1.0 mobile application',
          },
        ),
      );

  static const _minimumRequestInterval = Duration(seconds: 1);

  final Dio _dio;
  DateTime? _lastRequestAt;

  @override
  Future<BusinessLocationModel?> reverseGeocode({
    required double latitude,
    required double longitude,
  }) async {
    await _respectRateLimit();

    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/reverse',
        queryParameters: {
          'format': 'jsonv2',
          'lat': latitude,
          'lon': longitude,
          'addressdetails': 1,
        },
      );
      final address = response.data?['address'] as Map<String, dynamic>?;
      if (address == null) {
        return null;
      }

      final road = _firstNonEmptyValue(address, const [
        'road',
        'pedestrian',
        'residential',
        'footway',
      ]);
      final houseNumber = _firstNonEmptyValue(address, const ['house_number']);
      final city = _firstNonEmptyValue(address, const [
        'city',
        'town',
        'village',
        'municipality',
        'county',
      ]);

      return BusinessLocationModel(
        city: city,
        address: [
          houseNumber,
          road,
        ].where((value) => value.isNotEmpty).join(' '),
        latitude: latitude,
        longitude: longitude,
      );
    } on DioException catch (error, stackTrace) {
      log(
        'Nominatim reverse geocoding failed: ${error.message}',
        name: 'NominatimDataSource',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<void> _respectRateLimit() async {
    final lastRequestAt = _lastRequestAt;
    if (lastRequestAt != null) {
      final elapsed = DateTime.now().difference(lastRequestAt);
      final delay = _minimumRequestInterval - elapsed;
      if (delay > Duration.zero) {
        await Future<void>.delayed(delay);
      }
    }
    _lastRequestAt = DateTime.now();
  }

  String _firstNonEmptyValue(Map<String, dynamic> values, List<String> keys) {
    for (final key in keys) {
      final value = values[key]?.toString().trim() ?? '';
      if (value.isNotEmpty) {
        return value;
      }
    }
    return '';
  }
}
