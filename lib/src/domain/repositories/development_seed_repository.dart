import 'package:multibook/src/core/errors/result.dart';

abstract class DevelopmentSeedRepository {
  Future<Result<int>> seedStays();
  Future<Result<int>> seedServices();
}
