import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/config/app_config.dart';
import 'package:multibook/src/core/errors/api_exception.dart';

@lazySingleton
class ApiClient {
  ApiClient(this._firebaseAuth)
    : _dio = Dio(
        BaseOptions(
          baseUrl: _requiredBaseUrl(),
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 20),
          sendTimeout: const Duration(seconds: 20),
          headers: const {'Accept': 'application/json'},
        ),
      ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final user = _firebaseAuth.currentUser;
          if (user == null) {
            return handler.reject(
              DioException(
                requestOptions: options,
                error: const ApiException('You need to sign in first.'),
              ),
            );
          }
          final token = await user.getIdToken();
          if (token == null || token.isEmpty) {
            return handler.reject(
              DioException(
                requestOptions: options,
                error: const ApiException(
                  'Unable to authenticate this request.',
                ),
              ),
            );
          }
          options.headers['Authorization'] = 'Bearer $token';
          handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            log(
              '${response.requestOptions.method} ${response.requestOptions.uri} → ${response.statusCode}\n${response.data}',
              name: 'ApiClient',
            );
          }
          handler.next(response);
        },
        onError: (error, handler) {
          if (kDebugMode) {
            log(
              '${error.requestOptions.method} ${error.requestOptions.uri} → ${error.response?.statusCode}\n${error.response?.data}',
              name: 'ApiClient',
              error: error.error,
            );
          }
          handler.next(error);
        },
      ),
    );
  }

  final FirebaseAuth _firebaseAuth;
  final Dio _dio;

  Future<Response<Map<String, dynamic>>> get(String path) =>
      _request(() => _dio.get<Map<String, dynamic>>(path));

  Future<Response<Map<String, dynamic>>> patch(
    String path, {
    required Map<String, dynamic> data,
  }) => _request(() => _dio.patch<Map<String, dynamic>>(path, data: data));

  Future<Response<Map<String, dynamic>>> put(
    String path, {
    required Map<String, dynamic> data,
  }) => _request(() => _dio.put<Map<String, dynamic>>(path, data: data));

  Future<Response<Map<String, dynamic>>> _request(
    Future<Response<Map<String, dynamic>>> Function() request,
  ) async {
    try {
      return await request();
    } on DioException catch (error) {
      final payload = error.response?.data;
      final apiMessage = payload is Map<String, dynamic>
          ? ((payload['error'] as Map<String, dynamic>?)?['message'] as String?)
          : null;
      throw ApiException(
        apiMessage ?? 'Unable to reach the MultiBook service.',
        statusCode: error.response?.statusCode,
      );
    }
  }

  static String _requiredBaseUrl() {
    if (AppConfig.apiBaseUrl.isEmpty) {
      throw StateError(
        'MULTIBOOK_API_BASE_URL must be supplied with --dart-define.',
      );
    }
    return AppConfig.apiBaseUrl;
  }
}
