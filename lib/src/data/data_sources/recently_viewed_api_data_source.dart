import 'package:injectable/injectable.dart';
import 'package:multibook/src/data/data_sources/api_client.dart';
import 'package:multibook/src/data/data_sources/firebase_storage_data_source.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/models/business_model.dart';

@lazySingleton
class RecentlyViewedApiDataSource {
  RecentlyViewedApiDataSource(this._client, this._storage);
  final ApiClient _client;
  final FirebaseStorageDataSource _storage;

  Future<void> record(String businessId) =>
      _client.put('/v1/recently-viewed/$businessId', data: const {});

  Future<List<BusinessModel>> list(BusinessType type, {int limit = 10}) async {
    final response = await _client.get(
      '/v1/recently-viewed',
      queryParameters: {'type': type.name, 'limit': limit},
    );
    final businesses = (response.data!['items'] as List)
        .cast<Map<String, dynamic>>()
        .map(BusinessModel.fromMap);
    return Future.wait(businesses.map(_resolve));
  }

  Future<BusinessModel> _resolve(BusinessModel business) async {
    Future<String?> url(String? path) => path == null || path.isEmpty
        ? Future.value(path)
        : _storage.getDownloadUrl(storagePath: path);
    return business.copyWith(
      logoUrl: await url(business.logoUrl),
      coverPhotoUrl: await url(business.coverPhotoUrl),
      photoUrls: (await Future.wait(
        business.photoUrls.map(url),
      )).whereType<String>().toList(),
    );
  }
}
