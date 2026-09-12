import 'package:multibook/src/core/config/app_flavor.dart';

abstract final class AppEnvironment {
  static late final AppFlavor flavor;

  static void initialize(AppFlavor value) {
    flavor = value;
  }

  static bool get isDevelopment => flavor == AppFlavor.dev;
}
