import 'dart:developer';

import 'package:aquabook/src/features/introduction/domain/models/country_model/country_model.dart';
import 'package:dio/dio.dart';

class CountryRepository {
  CountryRepository({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: 'https://restcountries.com/v3.1/',
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
            ),
          );

  final Dio _dio;

  Future<List<CountryModel>?> fetchAll() async {
    try {
      final res = await _dio.get(
        '/all',
        queryParameters: {'fields': 'area,capital,currencies,languages,name'},
      );
      final data = res.data as List<dynamic>;

      return data
          .map((e) => CountryModelMapper.fromMap(e as Map<String, dynamic>))
          .toList();
    } catch (e, s) {
      log('Error fetching countries', error: e, stackTrace: s);
    }
    return null;
  }

  Future<List<CountryModel>?> searchByName(String query) async {
    final q = query.trim();
    if (q.isEmpty) return null;

    try {
      final res = await _dio.get(
        '/name/${Uri.encodeComponent(q)}',
        queryParameters: {
          'fields': 'area,capital,currencies,languages,name',
          'fullText': false,
        },
      );
      final data = res.data as List<dynamic>;

      return data
          .map((e) => CountryModelMapper.fromMap(e as Map<String, dynamic>))
          .toList();
    } catch (e, s) {
      log('Error searching countries by name', error: e, stackTrace: s);
    }
    return null;
  }
}
