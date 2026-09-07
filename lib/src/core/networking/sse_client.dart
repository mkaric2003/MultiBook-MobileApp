import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/networking/api_client.dart';
import 'package:multibook/src/core/networking/sse_connection.dart';

@lazySingleton
class SseClient {
  SseClient(this._client);

  final ApiClient _client;

  Stream<T> watch<T>({
    required String path,
    required String eventName,
    required T Function(String) decode,
  }) => SseConnection<T>(
    client: _client,
    path: path,
    eventName: eventName,
    decode: decode,
  ).stream;
}
