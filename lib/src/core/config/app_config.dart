import 'package:multibook/src/core/config/app_environment.dart';
import 'package:multibook/src/core/config/app_flavor.dart';

abstract final class AppConfig {
  static const _devGoogleServerClientId =
      '113851119343-ia9cv72a75vjd83s0bipkq2l929q4is0.apps.googleusercontent.com';
  static const _prodGoogleServerClientId = String.fromEnvironment(
    'MULTIBOOK_PROD_GOOGLE_SERVER_CLIENT_ID',
  );

  static const _devApiBaseUrl = String.fromEnvironment(
    'MULTIBOOK_DEV_API_BASE_URL',
    defaultValue: String.fromEnvironment('MULTIBOOK_API_BASE_URL'),
  );
  static const _prodApiBaseUrl = String.fromEnvironment(
    'MULTIBOOK_PROD_API_BASE_URL',
  );

  static String get googleServerClientId => switch (AppEnvironment.flavor) {
    AppFlavor.dev => _devGoogleServerClientId,
    AppFlavor.prod => _prodGoogleServerClientId,
  };

  static String get apiBaseUrl => switch (AppEnvironment.flavor) {
    AppFlavor.dev => _devApiBaseUrl,
    AppFlavor.prod => _prodApiBaseUrl,
  };
}
