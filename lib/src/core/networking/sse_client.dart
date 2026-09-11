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
    eventNames: {eventName},
    decode: (_, data) => decode(data),
  ).stream;

  Stream<T> watchEvents<T>({
    required String path,
    required Set<String> eventNames,
    required T Function(String eventName, String data) decode,
  }) => SseConnection<T>(
    client: _client,
    path: path,
    eventNames: eventNames,
    decode: decode,
  ).stream;
}
