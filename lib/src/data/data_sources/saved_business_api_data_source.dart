import 'package:injectable/injectable.dart';
import 'package:multibook/src/data/data_sources/api_client.dart';
import 'package:multibook/src/data/data_sources/firebase_storage_data_source.dart';
import 'package:multibook/src/data/models/business_model.dart';

@lazySingleton
class SavedBusinessApiDataSource {
  SavedBusinessApiDataSource(this._client, this._storage);
  final ApiClient _client;
  final FirebaseStorageDataSource _storage;

  Future<void> save(String businessId) =>
      _client.put('/v1/saved-businesses/$businessId', data: const {});
  Future<void> remove(String businessId) =>
      _client.delete('/v1/saved-businesses/$businessId');
  Future<bool> isSaved(String businessId) async {
    final response = await _client.get('/v1/saved-businesses/$businessId');
    return response.data!['isSaved'] as bool;
  }

  Future<List<BusinessModel>> list() async {
    final response = await _client.get('/v1/saved-businesses');
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
