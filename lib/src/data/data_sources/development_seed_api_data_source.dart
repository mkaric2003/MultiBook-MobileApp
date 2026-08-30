import 'package:injectable/injectable.dart';
import 'package:multibook/src/data/data_sources/api_client.dart';

@lazySingleton
class DevelopmentSeedApiDataSource {
  DevelopmentSeedApiDataSource(this._client);
  final ApiClient _client;

  Future<int> seedStays() => _seed('/v1/development/seed/stays');
  Future<int> seedServices() => _seed('/v1/development/seed/services');

  Future<int> _seed(String path) async {
    final response = await _client.post(path, data: const {});
    return response.data!['created'] as int;
  }
}
