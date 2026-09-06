import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/api_exception.dart';
import 'package:multibook/src/data/data_sources/api_client.dart';
import 'package:multibook/src/data/models/dashboard_metrics.dart';

@lazySingleton
class DashboardMetricsApiDataSource {
  DashboardMetricsApiDataSource(this._client);

  final ApiClient _client;

  Stream<DashboardMetrics> watchDashboardMetrics(String businessId) {
    StreamSubscription<DashboardMetrics>? subscription;
    Timer? reconnectTimer;
    var reconnectDelay = const Duration(seconds: 1);
    var reconnectScheduled = false;
    var stopped = false;
    late StreamController<DashboardMetrics> controller;
    late void Function() connect;

    void scheduleReconnect() {
      if (stopped || controller.isClosed || reconnectScheduled) return;
      reconnectScheduled = true;
      reconnectTimer = Timer(reconnectDelay, () {
        reconnectScheduled = false;
        connect();
      });
      reconnectDelay = Duration(
        seconds: (reconnectDelay.inSeconds * 2).clamp(1, 30).toInt(),
      );
    }

    void handleError(Object error, StackTrace stackTrace) {
      if (error is! ApiException || _isPermanent(error)) {
        if (!controller.isClosed) {
          stopped = true;
          controller.addError(error, stackTrace);
          unawaited(controller.close());
        }
        return;
      }
      if (!controller.isClosed) {
        log(
          'Dashboard metrics stream disconnected; reconnecting.',
          name: 'DashboardMetricsApiDataSource',
          error: error,
          stackTrace: stackTrace,
        );
        scheduleReconnect();
      }
    }

    connect = () {
      if (stopped || controller.isClosed) return;
      subscription = _dashboardEventPayloads(businessId)
          .map(DashboardMetricsMapper.fromJson)
          .listen(
            (metrics) {
              reconnectDelay = const Duration(seconds: 1);
              if (!stopped) controller.add(metrics);
            },
            onError: handleError,
            onDone: scheduleReconnect,
            cancelOnError: true,
          );
    };

    controller = StreamController<DashboardMetrics>(
      onListen: connect,
      onCancel: () async {
        stopped = true;
        reconnectTimer?.cancel();
        await subscription?.cancel();
      },
    );
    return controller.stream;
  }

  Stream<String> _dashboardEventPayloads(String businessId) async* {
    final lines = _client
        .openSseStream(
          '/v1/businesses/$businessId/dashboard-metrics/stream',
        )
        .transform(const LineSplitter());
    String? eventName;
    final data = StringBuffer();
    await for (final line in lines) {
      if (line.isEmpty) {
        if (eventName == 'dashboard_metrics' && data.isNotEmpty) {
          yield data.toString();
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
