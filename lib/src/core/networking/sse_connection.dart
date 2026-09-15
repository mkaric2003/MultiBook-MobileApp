import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:multibook/src/core/errors/api_exception.dart';
import 'package:multibook/src/core/networking/api_client.dart';

class SseConnection<T> {
  SseConnection({
    required ApiClient client,
    required String path,
    required Set<String> eventNames,
    required T Function(String eventName, String data) decode,
  }) : _client = client,
       _path = path,
       _eventNames = eventNames,
       _decode = decode {
    _controller = StreamController<T>(onListen: _connect, onCancel: _stop);
  }

  final ApiClient _client;
  final String _path;
  final Set<String> _eventNames;
  final T Function(String eventName, String data) _decode;
  late final StreamController<T> _controller;
  StreamSubscription<T>? _subscription;
  Timer? _reconnectTimer;
  Duration _reconnectDelay = const Duration(seconds: 1);
  bool _reconnectScheduled = false;
  bool _stopped = false;

  Stream<T> get stream => _controller.stream;

  void _connect() {
    if (_stopped || _controller.isClosed) return;
    _subscription = _events()
        .map((event) => _decode(event.name, event.data))
        .listen(
          _onData,
          onError: _onError,
          onDone: _scheduleReconnect,
          cancelOnError: true,
        );
  }

  void _onData(T value) {
    _reconnectDelay = const Duration(seconds: 1);
    if (!_stopped) _controller.add(value);
  }

  void _onError(Object error, StackTrace stackTrace) {
    if (error is! ApiException || _isPermanent(error)) {
      _stopped = true;
      if (!_controller.isClosed) {
        _controller.addError(error, stackTrace);
        unawaited(_controller.close());
      }
      return;
    }
    log(
      'SSE stream disconnected; reconnecting.',
      name: 'SseConnection',
      error: error,
      stackTrace: stackTrace,
    );
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (_stopped || _controller.isClosed || _reconnectScheduled) return;
    _reconnectScheduled = true;
    _reconnectTimer = Timer(_reconnectDelay, _reconnect);
    _reconnectDelay = Duration(
      seconds: (_reconnectDelay.inSeconds * 2).clamp(1, 30).toInt(),
    );
  }

  void _reconnect() {
    _reconnectScheduled = false;
    _connect();
  }

  Future<void> _stop() async {
    _stopped = true;
    _reconnectTimer?.cancel();
    await _subscription?.cancel();
  }

  Stream<({String name, String data})> _events() async* {
    final lines = _client.openSseStream(_path).transform(const LineSplitter());
    String? eventName;
    final data = StringBuffer();
    await for (final line in lines) {
      if (line.isEmpty) {
        if (eventName != null &&
            _eventNames.contains(eventName) &&
            data.isNotEmpty) {
          yield (name: eventName, data: data.toString());
        }
        eventName = null;
        data.clear();
        continue;
      }
      if (line.startsWith(':')) continue;
      if (line.startsWith('event:')) {
        eventName = line.substring(6).trim();
      } else if (line.startsWith('data:')) {
        if (data.isNotEmpty) data.write('\n');
        data.write(line.substring(5).trimLeft());
      }
    }
  }

  bool _isPermanent(ApiException error) =>
      const {401, 403, 404, 422}.contains(error.statusCode);
}
