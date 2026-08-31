import 'package:injectable/injectable.dart';
import 'package:multibook/src/data/data_sources/api_client.dart';
import 'package:multibook/src/data/data_sources/firebase_storage_data_source.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/models/business_model.dart';

@lazySingleton
class CustomerDiscoveryApiDataSource {
  CustomerDiscoveryApiDataSource(this._client, this._storage);
  final ApiClient _client;
  final FirebaseStorageDataSource _storage;

  Future<List<BusinessModel>> popularNearCity({
    required BusinessType type,
    required String city,
    required int offset,
    int limit = 10,
  }) async {
    return _listBusinesses(
      type: type,
      city: city,
      offset: offset,
      limit: limit,
    );
  }

  Future<List<BusinessModel>> listBusinesses({
    required BusinessType type,
    required int offset,
    int limit = 10,
  }) => _listBusinesses(type: type, offset: offset, limit: limit);

  Future<List<BusinessModel>> searchBusinesses({
    required BusinessType type,
    required String query,
    int limit = 20,
  }) async {
    final response = await _client.get(
      '/v1/discovery/search',
      queryParameters: {'type': type.name, 'query': query, 'limit': limit},
    );
    final items = (response.data!['items'] as List)
        .cast<Map<String, dynamic>>()
        .map(BusinessModel.fromMap);
    return Future.wait(items.map(_resolve));
  }

  Future<List<BusinessModel>> _listBusinesses({
    required BusinessType type,
    String? city,
    required int offset,
    required int limit,
  }) async {
    final response = await _client.get(
      '/v1/discovery/businesses',
      queryParameters: {
        'type': type.name,
        if (city?.trim().isNotEmpty ?? false) 'city': city!.trim(),
        'limit': limit,
        'offset': offset,
      },
    );
    final items = (response.data!['items'] as List)
        .cast<Map<String, dynamic>>()
        .map(BusinessModel.fromMap);
    return Future.wait(items.map(_resolve));
  }

  Future<List<BusinessModel>> recommendedStays() async {
    final response = await _client.get('/v1/discovery/recommended-stays');
    final items = (response.data!['items'] as List)
        .cast<Map<String, dynamic>>()
        .map(BusinessModel.fromMap);
    return Future.wait(items.map(_resolve));
  }

  Future<BusinessModel> _resolve(BusinessModel business) async {
    Future<String?> url(String? value) => value == null || value.isEmpty
        ? Future.value(value)
        : _storage.getDownloadUrl(storagePath: value);
    return business.copyWith(
      logoUrl: await url(business.logoUrl),
      coverPhotoUrl: await url(business.coverPhotoUrl),
      photoUrls: (await Future.wait(
        business.photoUrls.map(url),
      )).whereType<String>().toList(),
    );
  }
}
