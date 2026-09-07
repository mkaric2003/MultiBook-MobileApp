import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/networking/api_client.dart';
import 'package:multibook/src/data/data_sources/firebase_storage_data_source.dart';
import 'package:multibook/src/data/models/business_model.dart';

@lazySingleton
class BusinessesApiDataSource {
  BusinessesApiDataSource(this._client, this._storageDataSource);

  final ApiClient _client;
  final FirebaseStorageDataSource _storageDataSource;

  Future<BusinessModel> createBusiness(BusinessModel business) async {
    final response = await _client.post(
      '/v1/businesses',
      data: business.toMap(),
    );
    return _decode(response.data!);
  }

  Future<List<BusinessModel>> getOwnedBusinesses() async {
    final response = await _client.get('/v1/businesses');
    final items = response.data!['items'] as List<dynamic>;
    final businesses = items
        .cast<Map<String, dynamic>>()
        .map(BusinessModel.fromMap)
        .toList();
    return Future.wait(businesses.map(_resolveMediaUrls));
  }

  Future<BusinessModel> getOwnedBusiness(String businessId) async {
    final response = await _client.get('/v1/businesses/$businessId');
    return _decode(response.data!);
  }

  Future<BusinessModel> updateBusiness(BusinessModel business) async {
    final response = await _client.put(
      '/v1/businesses/${business.id}',
      // The UI uses resolved Firebase download URLs to render images, but the
      // API persists stable Firebase Storage paths. Convert URLs back before
      // writing so a subsequent response never stores an expiring token URL.
      data: _storagePathsBusiness(business).toMap(),
    );
    return _decode(response.data!);
  }

  Future<BusinessModel> _decode(Map<String, dynamic> data) =>
      _resolveMediaUrls(BusinessModel.fromMap(data));

  Future<BusinessModel> _resolveMediaUrls(BusinessModel business) async {
    final logoUrl = await _downloadUrl(business.logoUrl);
    final coverPhotoUrl = await _downloadUrl(business.coverPhotoUrl);
    final photoUrls = await Future.wait(business.photoUrls.map(_downloadUrl));
    return business.copyWith(
      logoUrl: logoUrl,
      coverPhotoUrl: coverPhotoUrl,
      photoUrls: photoUrls.whereType<String>().toList(),
    );
  }

  Future<String?> _downloadUrl(String? storagePath) async {
    if (storagePath == null || storagePath.isEmpty) return null;
    return _storageDataSource.getDownloadUrl(storagePath: storagePath);
  }

  BusinessModel _storagePathsBusiness(BusinessModel business) =>
      business.copyWith(
        logoUrl: _storagePathFromUrl(business.logoUrl),
        coverPhotoUrl: _storagePathFromUrl(business.coverPhotoUrl),
        photoUrls: business.photoUrls
            .map(_storagePathFromUrl)
            .whereType<String>()
            .toList(),
      );

  String? _storagePathFromUrl(String? value) {
    if (value == null || value.isEmpty) return value;
    final uri = Uri.tryParse(value);
    if (uri == null || !uri.hasScheme) return value;

    // Firebase download URLs encode the storage object after `/o/`, e.g.
    // `/o/businesses%2Fowner%2Fcover.webp?alt=media`.
    final marker = '/o/';
    final index = uri.path.indexOf(marker);
    if (index == -1) return value;
    return Uri.decodeComponent(uri.path.substring(index + marker.length));
  }
}
